Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1134C3C94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 04:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiBYDpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 22:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbiBYDpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:45:15 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E2254550;
        Thu, 24 Feb 2022 19:44:44 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220225034442epoutp031d962e134e1ec9dd086e76561e17b0d3~W6p8ClBT02904429044epoutp03c;
        Fri, 25 Feb 2022 03:44:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220225034442epoutp031d962e134e1ec9dd086e76561e17b0d3~W6p8ClBT02904429044epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645760682;
        bh=1iZdpCXEAZbRsOLrr9lAy8grQtrN6NFqPn/cdQ9GwG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e2oCbxBfpoW0Fx3WrxnvQNXCG9X/Tlz1p5CwVlTgqA53pqoDUKjS0UER3oZz1JBqg
         4aj3LblE3NhjsnCi8awDhDMEfMG0z1usr+rCnoWroRiQffHk1wWpxJZpKuE5uEVaQh
         8Wlaj7I6hadXCn3SCw/XJ1rAr+jSnR2wKUgTm2Ss=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220225034441epcas5p1eadca5356fef15af328f1804164ef447~W6p7j0Aax1918519185epcas5p1k;
        Fri, 25 Feb 2022 03:44:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K4bHW4tD4z4x9QT; Fri, 25 Feb
        2022 03:44:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.DC.05590.79058126; Fri, 25 Feb 2022 12:44:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220224121800epcas5p2bdfb52a9ae9e52068b73128cbe1895b7~WuA0NSwEI1060910609epcas5p2f;
        Thu, 24 Feb 2022 12:18:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220224121800epsmtrp2f24affef1a1e089cb16436d2e30fb89c~WuA0Ko9xd2135121351epsmtrp25;
        Thu, 24 Feb 2022 12:18:00 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-de-621850971644
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.01.29871.77777126; Thu, 24 Feb 2022 21:17:59 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220224121755epsmtip18a16fa986ab7cb514bc61b630525edd0~WuAvrUana1457514575epsmtip18;
        Thu, 24 Feb 2022 12:17:55 +0000 (GMT)
Date:   Thu, 24 Feb 2022 17:42:58 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@lst.de,
        javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Message-ID: <20220224121258.GB9117@test-zns>
MIME-Version: 1.0
In-Reply-To: <98ddab1b-6702-f121-9fef-0ce185888a1a@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzH59x79+7CDHQDjQPmQAtOyntjlw4glRPD3AZqSGbQ6A+6wp2F
        gN1td0FtJgKJHF7y0AQuJhgVICS6KMNjUQSBeFOLxEuJlzGiyysMUiBgl8b/Pr/v+f5+53d+
        Z34C3GKCbyOIkqlZpYyJEZKmRE3LIUeXvCB4wj2xwBZVdbbhSDu8zEMVD7JIdHFhDUfzd6d4
        KDcrn4+e9/ThSDdtjhr1hTzUv5qEoSnNJoa0P+RiqLyiFUN/lZYA1HBlEUOpXf0YejEhQq2b
        T0mU2zwI0Mx9DkONI05I29hBIF39JRIV/TzDR+l/1JLo9lwjjkrbNzA0lD0DUC/3gkS100kA
        tTy8T6Brc/MEmlvtING3N1YASslY46O+9Xbeew60biCA5sZ7SDonWc+n67gHfLrv4Q2CTi4e
        I2hdTxytuZpK0tU/fk2fHyoFdMNwIkmf6W7F6fylv0k6M1lP0nUp4zx6cWaECLIKjT4cyTIR
        rNKOlYXLI6JkUl9hQHDY+2EST3eRi8gLvS20kzGxrK/QLzDIxT8qZmuSQrt4JiZuSwpiVCqh
        2zuHlfI4NWsXKVepfYWsIiJGIVa4qphYVZxM6ipj1d4id/e3JFvGz6Ij51fP8RVFtqfacp7w
        EoEGpgETAaTEMGW0BEsDpgILqgHAmd47hCFYArBlNMkYPAMwK6mUv5uysnAXNxw0AjiWnM43
        BI8A5KZ68W0XQR2AdxI7eGlAICApJ9i1KdiW91AS+DQjZacqTn3PhxebKnY8llQI7G86sO0x
        o5xhRkUe38Cvwo6CaWKbTSh/qG/L4m3zXsoeNtW07/QNqQJTmPf7vzxDd37wl8wyI1vCx+03
        jV3bwGV9I2lISAdwtXvcmJ0PYHJ2MmlwvQt/065j24xTkVB3+yww6Pvhd53XjLo5zHw+jRl0
        M1h7eZftYWVVsbGONRz8J8nINGzXzZKGEa1gUPNNGcgGttxLz+Neus/AzrC4YYnktiaDU/tg
        6YbAgIdgVb1bMeBdBdasQhUrZVUShYeMPfn/n4fLYzVgZ9ccA2rB5J8Lrs0AE4BmAAW4cI/Z
        1FdWJyzMIpjTX7JKeZgyLoZVNQPJ1m/l4DZ7w+VbyypTh4nEXu5iT09PsZeHp0hoZdYpvc5Y
        UFJGzUazrIJV7uZhAhObREwyUXlv4eM5qbeoX/MoEZa+7jN0ruZXiw0TiS2YDV4sMP/ow8uY
        j/iUFx3qExX4zMEWpxI+De4qcrt1OsE8yJmTbjT0lw/xwuzXRkdwO31LuYuUse38AA/pPmrh
        f3PZ4WDKdOG9ifpX+ruG/S7UWVZCG9PRN2ZZPNR6g3pyvEgekXZJYjc2StkvO03HfnHm8fhR
        gpxwOnLsrLOj7M14cUpgdfHYrf1WS+0Hucn4iNHr7hc++dx0XU2knkwo8eF8B0byxtLVm9wG
        r0wnqZ7Uk0de02hr20ISjvukHxO7UlPIXD7vXeh4pWPfT2kDtdqYcOsmG9whDBuc5HyRxoMR
        EqpIRuSIK1XMfxKftK/0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxiG856vHtBuh+rgRYmZ3cwiuEIV5M2yLGoydhLcNMuyH8syV+QM
        CFBZj4jOqAXGjAUGFrBwUNfqIqF1bmJSwLabVPkoyOhWEVCBbm2Hs2uhE4KEr6WwZf6781zX
        ff96aFyiJzfQOcrDnEqpyJNSkYT5tnTT60VFMRlJA/0p6PveLhxZR56SyDRaRaFzU3M4muzw
        kEhbVS9C8/0DOHJ5X0C2YCOJnM+KMeRpWcaQ9ZIWQ82mTgxNNF0GyGIIYehMnxNDC7/JUedy
        gEJa+32AfIMChmwPEpDV5iCQ6+Z5Cn1zxSdC5UNtFPrRb8NRU/cShoarfQD9LCxQqM1bDNDt
        sUECXfNPEsj/zEGhr67PAFRWMSdCA4vd5K5XWde9dFYY76fYs6VBEdsujIrYgbHrBFuqf0Sw
        rv5CtsV4hmJvfHuKrRluAqxlRE2xJXc7cbb+72mKrSwNUmx72TjJhnwPiP0xH0W+mcnl5Rzh
        VIlvfRqZfXrxPFUwHnd0+us+XA3KozUggoZMMpyZ6sA1IJKWMBYAJ2zNYBXEwiuLd/DVvA42
        L02IViUvgIE/qrEwIJgt8Ce1g9QAmqaYBNi3TIfP65kUGKgoI8I+zlwWQfdj94qzjvkQOm9t
        CTtiZhusMOn+3ZzFoN44g62CKOho8BLhjDPxcHjpTyzcxZmNsGlpZT+CSYPBrioynF9iXoG3
        zN1YNYgSnmsLz7WF/9t6gBtBLFfA52fl8/ICuZIrkvGKfL5QmSU7eCi/Baw8UfzWNtBqnJLZ
        AUYDO4A0Ll0vTvk8OkMizlQc+4JTHTqgKszjeDvYSBPSGLFT4zggYbIUh7lcjivgVP9RjI7Y
        oMb2JJpr6oxHRSfeP3kTDMH9Tw5+ssfXe+L3BPmYT1axbGnbLpgbfsn91XVPR16a3trs36kJ
        lbzxV50sOzXZ4iOrY0Px31E/1JZH7UMX3W7tNvPQx9bi0K7PYgYbPan++853ZtY2THpU14b5
        9+5cvfo4oyjV+bKmK/f4qDJd1qqoh5sbFtYeGzGUzJb2AMAk9doyK6fqTs8lXZwfyUl87Uic
        YcdZfvFLXavYoI59atVvbpSkZdRXcjV77z7xqgN99p4bhC9ZVxs3bUqrkjvmtec+KK5NcIzv
        vtCxV4BwzQVdi+mRITUiOOl+O+AvF8r2tXvenU3f5LQWvmiNfri7R0rw2Qp5PK7iFf8AKN0B
        x7MDAAA=
X-CMS-MailID: 20220224121800epcas5p2bdfb52a9ae9e52068b73128cbe1895b7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_b2509_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
        <20220214080002.18381-3-nj.shetty@samsung.com>
        <20220217090700.b7n33vbkx5s4qbfq@garbanzo> <20220217125901.GA3781@test-zns>
        <YhWGDUyQkUcE6itt@bombadil.infradead.org>
        <98ddab1b-6702-f121-9fef-0ce185888a1a@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_b2509_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Feb 23, 2022 at 10:29:18AM +0900, Damien Le Moal wrote:
> On 2/23/22 09:55, Luis Chamberlain wrote:
> > On Thu, Feb 17, 2022 at 06:29:01PM +0530, Nitesh Shetty wrote:
> >>  Thu, Feb 17, 2022 at 01:07:00AM -0800, Luis Chamberlain wrote:
> >>> The subject says limits for copy-offload...
> >>>
> >>> On Mon, Feb 14, 2022 at 01:29:52PM +0530, Nitesh Shetty wrote:
> >>>> Add device limits as sysfs entries,
> >>>>         - copy_offload (RW)
> >>>>         - copy_max_bytes (RW)
> >>>>         - copy_max_hw_bytes (RO)
> >>>>         - copy_max_range_bytes (RW)
> >>>>         - copy_max_range_hw_bytes (RO)
> >>>>         - copy_max_nr_ranges (RW)
> >>>>         - copy_max_nr_ranges_hw (RO)
> >>>
> >>> Some of these seem like generic... and also I see a few more max_hw ones
> >>> not listed above...
> >>>
> >> queue_limits and sysfs entries are differently named.
> >> All sysfs entries start with copy_* prefix. Also it makes easy to lookup
> >> all copy sysfs.
> >> For queue limits naming, I tried to following existing queue limit
> >> convention (like discard).
> > 
> > My point was that your subject seems to indicate the changes are just
> > for copy-offload, but you seem to be adding generic queue limits as
> > well. Is that correct? If so then perhaps the subject should be changed
> > or the patch split up.
> > 
> >>>> +static ssize_t queue_copy_offload_store(struct request_queue *q,
> >>>> +				       const char *page, size_t count)
> >>>> +{
> >>>> +	unsigned long copy_offload;
> >>>> +	ssize_t ret = queue_var_store(&copy_offload, page, count);
> >>>> +
> >>>> +	if (ret < 0)
> >>>> +		return ret;
> >>>> +
> >>>> +	if (copy_offload && !q->limits.max_hw_copy_sectors)
> >>>> +		return -EINVAL;
> >>>
> >>>
> >>> If the kernel schedules, copy_offload may still be true and
> >>> max_hw_copy_sectors may be set to 0. Is that an issue?
> >>>
> >>
> >> This check ensures that, we dont enable offload if device doesnt support
> >> offload. I feel it shouldn't be an issue.
> > 
> > My point was this:
> > 
> > CPU1                                       CPU2
> > Time
> > 1) if (copy_offload 
> > 2)    ---> preemption so it schedules      
> > 3)    ---> some other high priority task  Sets q->limits.max_hw_copy_sectors to 0
> > 4) && !q->limits.max_hw_copy_sectors)
> > 
> > Can something bad happen if we allow for this?
> 
> max_hw_copy_sectors describes the device capability to offload copy. So
> this is read-only and "max_hw_copy_sectors != 0" means that the device
> supports copy offload (this attribute should really be named
> max_hw_copy_offload_sectors).
>
Yes, it does make sense to change prefix to copy_offload_*, but downside
being sysfs attributes becomes too long.

> The actual loop to issue copy offload BIOs, however, must use the soft
> version of the attribute: max_copy_sectors, which defaults to
> max_hw_copy_sectors if copy offload is truned on and I guess to
> max_sectors for the emulation case.
> 
> Now, with this in mind, I do not see how allowing max_copy_sectors to be
> 0 makes sense. I fail to see why that should be allowed since:
> 1) If copy_offload is true, we will rely on the device and chunk copy
> offload BIOs up to max_copy_sectors
> 2) If copy_offload is false (or device does not support it), emulation
> will be used by issuing read/write BIOs of up to max_copy_sectors.
> 
> Thus max_copy_sectors must always be at least equal to the device
> minimum IO size, that is, the logical block size.

Agreed, if device doesn't suppport offload, soft limit should be based on
limits of READ/WRITE IOs.

--
Nitesh Shetty

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_b2509_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_b2509_--
