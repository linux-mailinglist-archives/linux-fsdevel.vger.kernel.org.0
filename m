Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D873B4C3C8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 04:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiBYDos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 22:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiBYDor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:44:47 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9AC21BC4F;
        Thu, 24 Feb 2022 19:44:15 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220225034414epoutp0450718f72c78f874e0fb57b31c70ccadf~W6phiETuI0602606026epoutp04k;
        Fri, 25 Feb 2022 03:44:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220225034414epoutp0450718f72c78f874e0fb57b31c70ccadf~W6phiETuI0602606026epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645760654;
        bh=70BW6FiDnVYnABWjiPvBtlxZq7Trrd1lyFdONgt3Kx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=udWPccjToqcFRGko4Qp7cQZMEt3LOUUrtYsUSi0t60b/WxPxL8HmANioqmDydjdDZ
         d7otW4RkgR3SSEIj3itTSj4Yi6IafVaPrVDCMDuXDdNDWh4KnDk20WBdNFp5ICs6hX
         XCHYZBcixfEypFzYAksp/gSAKFqQPm5KhsddNyto=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220225034413epcas5p132b963987cc4f7a5cbd9fff0a657529f~W6pg8XAN51032610326epcas5p1o;
        Fri, 25 Feb 2022 03:44:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K4bH82KPqz4x9QG; Fri, 25 Feb
        2022 03:44:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.BC.05590.48058126; Fri, 25 Feb 2022 12:44:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220224120720epcas5p4437444a45856edbf828bf377207a6f06~Wt3gHzRD_2573725737epcas5p47;
        Thu, 24 Feb 2022 12:07:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220224120719epsmtrp1c47bedc43baaf8c001c483aca859fc23~Wt3gEQOmk0539305393epsmtrp1f;
        Thu, 24 Feb 2022 12:07:19 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-a5-621850842539
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.30.29871.7F477126; Thu, 24 Feb 2022 21:07:19 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220224120715epsmtip1faf192d135aed15d61e8c768642ca090~Wt3brgvle0640906409epsmtip1c;
        Thu, 24 Feb 2022 12:07:15 +0000 (GMT)
Date:   Thu, 24 Feb 2022 17:32:18 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@lst.de, javier@javigon.com, chaitanyak@nvidia.com,
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
Message-ID: <20220224120218.GA9117@test-zns>
MIME-Version: 1.0
In-Reply-To: <YhWGDUyQkUcE6itt@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH97v39raw1V3x9bNGh1UYyLNS6g+i24yNuxOTsZDsD+PSXeEG
        qqXt2uJrQdE6kgoEqNNBJYrbGAMXngsBSwkWWbW+YB0IBkFG60TCw9eEgHStFxb/+5zvOed3
        zu+cHAEe1M8XCZRqA6tTMyoxGUg0dYSHRZ1KhvtiZ5uXoFrnHzhq7X/OQ5cfFJLo3NQMjiav
        jvCQubCEj1zuJcg2cZ6HuqZPYGikwYuh1h/NGKq63Imhfyp/Ash66SmGTDe7MDQ3LEGd3nES
        me29AHl6LBiy3Y9ArbYbBHJdKSPRxV88fJR3r5lEbWM2HFU65jHUV+QB6I5ljkTN7hMAdQz2
        EKhmbJJAY9M3SJRb/xKg7/Jn+Ojuawfvkw20668k2jJ0m6SLjRN8usXygE/fHawnaGP5AEG7
        bmfRDdUmkm78+Th9pq8S0Nb+HJI+easTp0uevSDpAuMEST/13CfoybYeMnnlngNbM1gmjdUF
        s+pUTZpSnb5NnJSi2KGIl8VKoiQJaIs4WM1kstvE8t3JUTuVKt8QxcEHGVWWT0pm9HpxzEdb
        dZosAxucodEbtolZbZpKK9VG65lMfZY6PVrNGhIlsbGb432BXx/ImG+y4lrXysPuahuRA8xL
        T4MAAaSksK7jCe80CBQEUVYA82qn+X5HEPUMwHPuvZzjXwCdZV28xYznxm6cc9gArCgbJzjj
        EYBT42Vv0gkqBE5MmX1RAgFJRcCbXoFfXk6FwbaiAszPOPWShMV39vhDllFfwq72EL8spCLh
        QP9DHsdL4Y1SN+HnAEoGPeNm0s8rqA2wvcmBcf2UBsICO+RYDk/NmXCOl8Enjt/5HIvgaGEu
        398mpPIAnL41hHFGCYDGIiPJRX0Mu1tfLzSXAUtf5QNOXwvPOmsW9CWwYNa9UFkImy8s8gb4
        W235wjurYe+rEwtMQ4frMckNqAWDDydziSLwgeWt31neqsdxJCy3PiMtvsHg1BpYOS/gMBzW
        XokpB7xqsJrV6jPTWX28Nk7NHvp/4amazAbw5sY2JTWDvx9ORdsBJgB2AAW4eLlwJHvVviBh
        GnPkKKvTKHRZKlZvB/G+XRXjohWpGt+Rqg0KiTQhViqTyaQJcTKJeJXQmV7HBFHpjIE9wLJa
        VreYhwkCRDnY+euNmpCpGHjlqq39pOU49acpvfH2ZlE+KZcOdo72Do+qbN+PtPcqj1XsF2/s
        Xpdm9U6UCszbVyQW79rpdn6z1vFrR1x5nf3IOzse1SSOVBe2HB5N2W06l/3uXJZhPQLVe0OH
        u+4wqy9cP1vpbRl4D42/L4zLeVwBLl47+Fng+vpPncdeK+WENSpUGP5CgcJAoWg4VpmroN3u
        ggRniTlAvKt2/0CusTgKfTv4hcTryeT31DVLPwzNvic6PCSvv3CoaN0PW8581f30qPx0/5rQ
        iMgXlqEg1Uz93QpHTwqTNLbs0rGYjcdDXL2fK8+YrlVV9alno/d7+sLtU0eyj9I1M2JCn8FI
        NuE6PfMfIi36juwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7bCSnO73EvEkg88H9S3WnzrGbLHn5mdW
        i9V3+9kspn34yWzx/uBjVotJ/TPYLS4/4bPY+242q8WFH41MFo83/Wey2LNoEpPFytVHmSye
        L1/MaLF74Ucmi87TF5gs/jw0tDj6/y2bxaRD1xgtnl6dxWSx95a2xZ69J1ksLu+aw2Yxf9lT
        dovu6zvYLPa93stssfz4PyaLGxOeMlqcm/WHzWLHk0ZGi8P3rrJYrHv9nsXi9Y+TbBZtG78y
        WrT2/GS3OP/3OKuDssflK94es+6fZfOY2PyO3WPnrLvsHufvbWTxaF5wh8Xj8tlSj02rOtk8
        Ni+p95h8Yzmjx+6bDWweTWeOMnvM+PSFzaO3+R2bx8ent1g83u+7yhYgFsVlk5Kak1mWWqRv
        l8CV8XrtW7aCySIVL38uYWtgfM3XxcjJISFgIvG5+SJzFyMXh5DAbkaJizNbWSESkhLL/h5h
        hrCFJVb+e84OUfSEUeLw/K+MIAkWAVWJdx8mARVxcLAJaEuc/s8BEhYR0JDYN6GXCaSeWeA3
        m8TGuQfBaoQFwiQuHFAFqeEV0JG4c/MBK9RiJoltk7YyQyQEJU7OfMICYjMLaEnc+PeSCaSX
        WUBaYvk/sPmcAmYST99OYgOxRQWUJQ5sO840gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJueW2xY
        YJiXWq5XnJhbXJqXrpecn7uJEZx+tDR3MG5f9UHvECMTB+MhRgkOZiURXtNCsSQh3pTEyqrU
        ovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamHwNn0S+lbMNubz+sfN1
        7XCuexHyIiFTThYsLfgxoXSFOf81m4SismdJ2a//3BbvW2xj0pyu1PpjbvIdU5cNRpkLmlL5
        7jx4Jn+x7/uRXumeosrdGntajJwM3a7Mm/u4kP3Jqhn7W6TkVfYK8qgqvIqZ2H7D5lBpC3ON
        ZIvkxBQx7ZNKq2ZMEy33vcgVcLeh8Y0E+68zIXGtEVNTVFzUfeOVc6XLnU2lsrXlndd1bGNQ
        cpNwMrvL/sNdZMWUro0dhlbZLBunbF5x+4vBmamLTCIvrXju4tpapuN7VyViG4Osd7f192Oh
        jKxspa5rdM+EtC17Ge0r+FbpbfwmjVy7v9PFwgrfrvgScSfBMkiJpTgj0VCLuag4EQDIVSLd
        rgMAAA==
X-CMS-MailID: 20220224120720epcas5p4437444a45856edbf828bf377207a6f06
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_b23b0_"
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_b23b0_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Feb 22, 2022 at 04:55:41PM -0800, Luis Chamberlain wrote:
> On Thu, Feb 17, 2022 at 06:29:01PM +0530, Nitesh Shetty wrote:
> >  Thu, Feb 17, 2022 at 01:07:00AM -0800, Luis Chamberlain wrote:
> > > The subject says limits for copy-offload...
> > > 
> > > On Mon, Feb 14, 2022 at 01:29:52PM +0530, Nitesh Shetty wrote:
> > > > Add device limits as sysfs entries,
> > > >         - copy_offload (RW)
> > > >         - copy_max_bytes (RW)
> > > >         - copy_max_hw_bytes (RO)
> > > >         - copy_max_range_bytes (RW)
> > > >         - copy_max_range_hw_bytes (RO)
> > > >         - copy_max_nr_ranges (RW)
> > > >         - copy_max_nr_ranges_hw (RO)
> > > 
> > > Some of these seem like generic... and also I see a few more max_hw ones
> > > not listed above...
> > >
> > queue_limits and sysfs entries are differently named.
> > All sysfs entries start with copy_* prefix. Also it makes easy to lookup
> > all copy sysfs.
> > For queue limits naming, I tried to following existing queue limit
> > convention (like discard).
> 
> My point was that your subject seems to indicate the changes are just
> for copy-offload, but you seem to be adding generic queue limits as
> well. Is that correct? If so then perhaps the subject should be changed
> or the patch split up.
>
Yeah, queue limits indicates copy offload. I think will make more
readable by adding copy_offload_* prefix.

> > > > +static ssize_t queue_copy_offload_store(struct request_queue *q,
> > > > +				       const char *page, size_t count)
> > > > +{
> > > > +	unsigned long copy_offload;
> > > > +	ssize_t ret = queue_var_store(&copy_offload, page, count);
> > > > +
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if (copy_offload && !q->limits.max_hw_copy_sectors)
> > > > +		return -EINVAL;
> > > 
> > > 
> > > If the kernel schedules, copy_offload may still be true and
> > > max_hw_copy_sectors may be set to 0. Is that an issue?
> > >
> > 
> > This check ensures that, we dont enable offload if device doesnt support
> > offload. I feel it shouldn't be an issue.
> 
> My point was this:
> 
> CPU1                                       CPU2
> Time
> 1) if (copy_offload 
> 2)    ---> preemption so it schedules      
> 3)    ---> some other high priority task  Sets q->limits.max_hw_copy_sectors to 0
> 4) && !q->limits.max_hw_copy_sectors)
> 
> Can something bad happen if we allow for this?
> 
> 

max_hw_copy_sectors is read only for user. And inside kernel, this is set
only by driver at initialization.


------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_b23b0_
Content-Type: text/plain; charset="utf-8"


------w44XasAgibz0dH83sqZUwD2VszzvD0Z8603isFAMQ6N2NX8f=_b23b0_--
