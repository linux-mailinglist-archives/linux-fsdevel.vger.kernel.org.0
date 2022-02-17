Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FAD4BB10E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 06:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiBRFBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 00:01:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiBRFAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:00:55 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153682BAA03;
        Thu, 17 Feb 2022 21:00:38 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220218050036epoutp023b79452c35d4668bac8b1525c55b5a1d~UyLNr7NGA2938129381epoutp02W;
        Fri, 18 Feb 2022 05:00:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220218050036epoutp023b79452c35d4668bac8b1525c55b5a1d~UyLNr7NGA2938129381epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645160436;
        bh=mh7UWvxwuvE8bNedSZzRwEQXl6IWDs4xsiiBLIhUrJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eFzp0kt8fRy4Ejk62NXpYAstnS2EQvs2AoO3NjISQEPM4evhbiMX3MPmTEV6P4IBX
         mwnaSmebWFvVDnOmS+PTFbezpTdZXWZOjn98xMDVAVovbmTckvlvV6OjsaT5Sca/QO
         glvyySR+b0aMvqITc0DDZF5osxu1Mx9/oKC8VeHA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220218050036epcas5p47dc1325db6e412d1dd5615722cab2134~UyLNRTZzn0649606496epcas5p4F;
        Fri, 18 Feb 2022 05:00:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K0KJV622Hz4x9Pv; Fri, 18 Feb
        2022 05:00:26 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.F4.06423.9E72F026; Fri, 18 Feb 2022 14:00:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220217133547epcas5p305c93f10e815e275374ca2f41d75a2aa~Uljuy6HZZ1991119911epcas5p3t;
        Thu, 17 Feb 2022 13:35:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220217133547epsmtrp21569afdc8d19e716eab1f6cdac5f9309~UljuxENvs1692816928epsmtrp2j;
        Thu, 17 Feb 2022 13:35:47 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-2a-620f27e94992
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.3F.29871.23F4E026; Thu, 17 Feb 2022 22:35:46 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217133542epsmtip2abd6e670ac9ebfdb75c8f643565fcf05~UljqV5HGc2615626156epsmtip2J;
        Thu, 17 Feb 2022 13:35:42 +0000 (GMT)
Date:   Thu, 17 Feb 2022 19:00:46 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
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
Subject: Re: [PATCH v3 01/10] block: make bio_map_kern() non static
Message-ID: <20220217133046.GA13770@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220217083631.34ii6gqdrknrmufv@garbanzo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+69vS246h1QdmTKWJvFqRRa5XHYQJbozPWxDffIFpMNL3Bt
        FWibPhwj2aTijIhoYYNAZQ63uW5gAME5oJRJHTBEVEQQVF6jzEyhPHwACnQtrYv/fX6/8/29
        c3i4z21uAG+PQsuqFUyKkPQmzl9cvUr876plCZKG1mBUcakZR/W9DziorO84iQomZnE03jjM
        QXnHC7mo07YUWewnOOjajB5Dw1UODNX/kIehX8uaMHTX9CNA5lOTGMpqu4ahuSEpanKMkSjP
        2g3QSJcRQ5Zba1G9pZVAnXXFJPr+5xEuyr5ZQ6KG+xYcmVoWMNRjGAHoinGORDU2PUAX+7sI
        VH5/nED3Z1pJdOjsI4C+PjrLRVfnWzhviejOG9to40A7Sedm2rl0rbGPS1/tP0vQmSV3CLqz
        XUdXlWaRdPVP++lvekyANvdmkPSBy004XTj1kKRzMu0kPTlyi6DHG7rIOP+dydFylkli1UGs
        IlGZtEchixFu+yB+Y3x4hEQqlkahSGGQgkllY4SbtseJN+9JcS5RGLSPSdE5XXGMRiMM3RCt
        Vuq0bJBcqdHGCFlVUooqTBWiYVI1OoUsRMFq35BKJOvCncJdyfKC2XKgqiXTnnzXTWSAKs4R
        4MWDVBjsHysijwBvng9lBtCe8afHmALw9JM8wm08BrAjewJ7FtIyN8FxP1gAPHj9AO42/gHw
        jvUg7lIR1GtwtqrUmYvHI6m1sM3Bc7n9qNdhgyFnMRFOPSKhvjLUxb7URljssHFdzKfE0Hh7
        CLj5RdhaZCNc7EVFwqdt5xY1AkoEL5xvwVx1IZXvDU+P9gNXLUhtgqZ6tbtRX3ivxa2HVAB8
        YLeQbn02gDOXBzzBhQBmGjJJtyoWdtTPe7qTQ8tMvmfklTD/UrnHvxTmPLV5/HxYc/IZi+CZ
        ihJPnuWwe1rvYRrWDUx79jgKYHWOiTCAV4zPTWd8rp6bg2GJeYo0OgfCqZehaYHnxtWwoi60
        BHBKwXJWpUmVsZpwlVTBfv7/yROVqVVg8Zet2VID+gYnQqwA4wErgDxc6MefaOQn+PCTmC/S
        WbUyXq1LYTVWEO48Vi4eIEhUOr+pQhsvDYuShEVERIRFrY+QCl/it8kqGR9KxmjZZJZVsepn
        cRjPKyAD2+vN7JMd7m2P+f2C1eivGzrqM18WAmeTRCtOXz+Jr/uqlhGs/+z97k8NXyZEDjh2
        H+pM/6s79spHZ2qXCSO38reX7XxnSan+gHLrx4Gn+NF8xy/5d94Ujw3V2ScDE9d1mP2zRvG3
        ewcDCgSs8pi6790Z9blmETmwP91UUTT4mCq67hu5sXH3ZXlN4IqF4B2vzr1H4nJxdVT8ldvD
        az55YfPwLr1ZJIjawZ1bkisgTfAPv6wtem/s7/GbGut63+jGNK2m9TBdgjZ8e+OeSTIZu2q+
        uG9lz8PmcotBVwSSHSpHqXj6w7NxdSFDOb/tHT9xNVkwPBY6X9nOq7blpln7o+82CwmNnJGu
        wdUa5j+jLjDh7gQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SX0xTZxjG951zenro1ua0MvwAM7K6GaWIQ9n2ZWHqsgsOEqMXBg2ZQJXT
        QoDa9IBTErdixYx/EatbpDpxQCAUkYkGcLSNLbIOu45GRIoDFmI7hh1tcWPaAGUrbJl3T97n
        +f2uXgqXXObFUYWqUlajkhdLSQHRMyBN2Lp9n+jIO8333kNd97/HkWn8Dx7qmDxHoq+CIRwF
        rE94SH/uEh+NeETI7L/MQ64XFRh60r2CIVOTHkPtHYMYmmlrBqj/m3kMVTlcGFqaTkGDK3Mk
        0tseAeQdNWDI/FiGTOYhAo18d4VEja1ePqoZ6yORxWfGUZs9jCF3vRegnwxLJOrzVAA0MDVK
        oBu+AIF8L4ZIdPbmAkCVtSE+Gl6283ZvZEYeZjKGX5wkc17n5zN3DJN8ZnjqJsHork0QzIiz
        jOk2VpHMrZbPmQvuNsD0j2tJ5vSPgzhz6dmfJFOn85PMvPcxwQQso+T+mGxBWj5bXHic1Wzb
        mScoGGi4T6hD+ImBmueEFtTg1SCKgnQqtC8FedVAQEnofgB7z/vItSIWti7f+3e0DraHZ/hr
        Iw+AU5W/YZGCoN+GoW7jPwBFkbQMOlaoyDma3gwt9XVYZI/TiyT06hdWRevoj+GVFQ8/koX0
        Vmj4eRpEsoT+HUCHJ23tLoZDDR4iknE6EbrDs1jEj9PxsC286o+i34eLjturmtfpjfBujx2r
        B2LDS7ThJdrwP30N4EYQy6q5EmUJl6JOUbGfJnPyEq5MpUw+eqykG6z+T+KWPtBrDCbbAEYB
        G4AULo0WBq3CIxJhvvxkOas5lqspK2Y5G4inCOl6oat6KFdCK+WlbBHLqlnNfy1GRcVpsc/w
        1CSbe/8hYP1Qedr10dyGtFD+00Xngz2ST6YDS/qE7WarNlZxfffzJHWaYlMjripIqKUPps8t
        y75W3j7QfOPo/FNFk+ZiI7dNGOO35pfKWi2db3wR1IWrCPNr4zmppUmmQ8Ge6eN/dc74xh4y
        lXcyXy3qbErNNs0Krg7vTFC0SB7ZLWepdy/kqpQXK2K4hTx8Ii66K+eUqyPr6r7huCJxRuDb
        nHi/usvTcvLLtyYaMvf+oMrY5a7VKURqerLO+asoe3TXm69UbZDJ19/d+yxvh1Ee5ZDv6NX6
        Dp85k16+eJDJmidnnbnlqqz0A36X+MGpwrET7VkfZIgH9RmJIinBFchTEnENJ/8blpJWdq4D
        AAA=
X-CMS-MailID: 20220217133547epcas5p305c93f10e815e275374ca2f41d75a2aa
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_8df09_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080558epcas5p17c1fb3b659b956908ff7215a61bcc0c9
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080558epcas5p17c1fb3b659b956908ff7215a61bcc0c9@epcas5p1.samsung.com>
        <20220214080002.18381-2-nj.shetty@samsung.com>
        <20220217083631.34ii6gqdrknrmufv@garbanzo>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_8df09_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Feb 17, 2022 at 12:36:31AM -0800, Luis Chamberlain wrote:
> On Mon, Feb 14, 2022 at 01:29:51PM +0530, Nitesh Shetty wrote:
> > From: SelvaKumar S <selvakuma.s1@samsung.com>
> > 
> > Make bio_map_kern() non static
> > 
> > Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> 
> This patch makes no sense on its own. I'd just merge it with
> its first user.
> 
>   Luis
>

acked. I will do it next version.

--
Nitesh

------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_8df09_
Content-Type: text/plain; charset="utf-8"


------Fq-YzQe-sCxQ_.ALiW-8FMdnFblVNc8pE5kaYAan9Jc7INV.=_8df09_--
