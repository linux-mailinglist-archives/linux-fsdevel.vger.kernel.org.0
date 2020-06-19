Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BF7201D13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgFSV0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 17:26:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36996 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgFSV0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592601966; x=1624137966;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OogOiox2qaR2vE6GVISlUh3XzhCFRTviCNXDzdL7cu0=;
  b=lzXd2BSf8r4SAqd2wnhrSVcdItoIgLe3Zt0MSAt8VUGin1u/R7wDNYUQ
   z3eqC2sJ8arB1TjuLSnaWTzyxwNMLV3uWNcOQ1oH1mVJp+HA1LRZIc9yB
   gPQj4K9jDkh7nXnBrpSpPDcAW5RhxFgGLk06/bJi5N7alEUcvLSXTAJ7a
   pVkzCtamIuc+Nf4bMeXgpQ7DG5nseniiqSfzWrNKv0UOlkg1pgGagqYcC
   0IH1uGwf6VEEOya3pejJaiq+TqERDWBnpVlubF6IeNhJGJLa7S68ZjuJr
   zCAhFWKZFivlDTec0X1qkBZQrV+qClJCmjszbR3CqHg+ni8Dj7N1lEWQv
   w==;
IronPort-SDR: yvOcG+SF2Iyy76ZvRx/rd0BwX8WA+BJEPNYwuil8iRri2wJzr3WHihFJmvL9dr+CA9p/32BGwI
 mGiZ4b8X6ytgjZJcN1c04ZXzVtN6l91sDs6fzfeBm5zH9xWuyLEClDt1Ox76k5GFdDTO85WfVD
 2mYIqPaAn99ewHkWnZ72I3jZFE39NBRYV/Hex0fiVZc0Q0/qTGwaUcf0kVyCiEN2v+D8Wb0Au7
 l57cDRJlXzP0sgdfPkT9rfQTiTa9MnEMAHzRjendnUVs7z9ycl/6tbE8EgrCRpRFYqe6PWntfv
 oes=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; 
   d="scan'208";a="249653208"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 05:25:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFKorzgiiyg0MdVszT20nSOMP91mAm/+6StJu1x10wq9vGSrrwZgZGlKNrbMTMcF7jVBt8vAFHKDXPgGDHPjcw1yGucblE48oWiOlwV8mDbL92JzUBJHw8hvBcObbPclX6yMaauKhvx55s96TWbT4lJmHWHiJMcGAy1GZfGMlOjcLXjP5EbRnago8TyrymhDmZOBDDwgyPW65TepAR0iNKDOJxZG937cCs5VMcf4EQzVVmoSbjmJ0AS+lCIARC9SNbDrzLyqofiWcWgr54+LjLBf+NtUn0JDhElae89MS5EjJ7ZIE33WVKfMrhNr4bkkK/ntuyYoCVwKk/A5Um6+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXAo1f0wAIfkTeTHcWPz16VrpmUqYr9Z1p6J2e9kbNg=;
 b=LoRXrt2F5y2Mt5RdWpVFqh2rG+OQlJ5qIlez6d9sGMAN68Nwvd8wwu/8VS906D59oo8WOQNw9Mhe1zcUQvT9yi8AGyIgh//ZJ/Rs1XXX9BqTVYcQrHNIMjEHYHjlsycEsQpfdGfamKOl0tBrzTvoM4Gb8ZH0XKu7LZx3SbfsQxwtwhkMjqRq3JtIOoFs7tFK9AUs0w8mvnWauQ5E1LJKEfX/TdLJltMAUPPnBIjAI5ZSH/2BgS+Z8LmIosi+Y1bq/yt3KNUoVsCyHHigJ9uXV5RN36sv7YTy16gV+t38dL3pdjapxXbVUKYeHncmmtK88L0dZkmSR7du1gIuVX8d4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXAo1f0wAIfkTeTHcWPz16VrpmUqYr9Z1p6J2e9kbNg=;
 b=PWH3RoLQLod+vagavrITxEJCR9IwRuO5z63E5gW47J2YjyKncJ8mBtrKE6lKYP9bj1r4MZK7CNIrusWFWnrqHCKVFZfzLsOifcY+9UPcR2b+Cme/jVpoLoXHEoRljJOVmJwD3iPref8xhxre+H6UiqH4ZU2h71x1U4cM9LbOOxE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5336.namprd04.prod.outlook.com (2603:10b6:a03:c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 21:25:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 21:25:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Thread-Topic: [RFC] Bypass filesystems for reading cached pages
Thread-Index: AQHWRlFoe2caIyYlK0mh4vA1o1hS7w==
Date:   Fri, 19 Jun 2020 21:25:57 +0000
Message-ID: <BYAPR04MB4965B610300E1D73873136AB86980@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <BYAPR04MB49655EAA09477CB716D39C8986980@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200619201216.GA8681@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 247201a8-6221-459d-a938-08d814975b6e
x-ms-traffictypediagnostic: BYAPR04MB5336:
x-microsoft-antispam-prvs: <BYAPR04MB5336469CA47109FAB493229386980@BYAPR04MB5336.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: caMP9iLaMGVc3vdDWwO7SGy6jy+UAALI30kWOdUFUuAc1uvaxQ0kh8FK7h/F9funOgfynZ78AUdcOzt2Hmi+uoZHN1E/VU9DfDLvEl2U7SsayTNc5fJCQT9TIRSfhVYrEQA2Szjqb9YcWrcN1w4qLO9oHKgSFfsCKurQve9wkrFJrLCaSs2l59w1CgkrOOOi0asinoikADFbLi906pACB6qg/W2nagTlhS3Av94hA5WUqysdOJdcDD8P4hRyQQnwUVjB2vzqGG8FsxYGsDiI8PDJYGvXln67ClG1EL4jX7rlokKLKWFYahtO3OS0FxvHxJcehOa1BSRz97yeWqtp0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(83380400001)(186003)(86362001)(478600001)(66446008)(66556008)(64756008)(66476007)(66946007)(7696005)(5660300002)(6916009)(33656002)(52536014)(71200400001)(76116006)(9686003)(316002)(54906003)(55016002)(6506007)(26005)(8676002)(2906002)(8936002)(4326008)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vVOn4fVxV0FfB7aG3YJtX0QSbb8TwnezIpDHxpW9D7LZ+H8H5GnFbS0Ophqe0MuskZYGDPJpftn6hxssOPR/XGpIx95yXAchmoFw1G3HU/3u7WdWNWikIJy8PRCV+xFjutDW8emY4nB72uceKtt1cQwGzrJfMItuLNIdZH/IAQycauMbEP2puhBmB0bdHiqK2119QHSyErpH33qTL+YdGxRLdBsrxo/iAslZuS4s1f0jYK4m8Pa1lXL+oe963hJyPksEuBLcL3QcOacVTW3YqpUGFI3RHCEi6sLmmhJp+AC6bVgA7BpIFzGymiOC47mvn2lGESHnz3AdyDHaqGSXNNxtTEoHgdBmvTu4I5FNSFZDOzLfBfsQZEIf1txKSfnOmgWtuihX85FCsiGRSh+z3eG13/MM4JlegFiMPd2y6yGC8vJYsCWlM5VFpjtGVpsJGVAHwBaMqUlffRbCwqYO1m1Ib4lh6m0Nj92wd6Tb+hw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247201a8-6221-459d-a938-08d814975b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 21:25:57.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sG2ePJEzfnfK+u3buVLA0WVdsY/D6kXckseLM7N2sqaD07QCHEMFV4KXnDOwyKYAem+3Mj6TspvBULEOCNliLJhRDH5UPv5I8jq/wnYvb8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5336
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew,=0A=
=0A=
On 6/19/20 1:12 PM, Matthew Wilcox wrote:=0A=
> On Fri, Jun 19, 2020 at 07:06:19PM +0000, Chaitanya Kulkarni wrote:=0A=
>> On 6/19/20 8:50 AM, Matthew Wilcox wrote:=0A=
>>> This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.=
=0A=
>>> The advantage of this patch is that we can avoid taking any filesystem=
=0A=
>>> lock, as long as the pages being accessed are in the cache (and we don'=
t=0A=
>>> need to readahead any pages into the cache).  We also avoid an indirect=
=0A=
>>> function call in these cases.=0A=
>>=0A=
>> I did a testing with NVMeOF target file backend with buffered I/O=0A=
>> enabled with your patch and setting the IOCB_CACHED for each I/O ored=0A=
>> '|' with IOCB_NOWAIT calling call_read_iter_cached() [1].=0A=
>>=0A=
>> The name was changed from call_read_iter() -> call_read_iter_cached() [2=
]).=0A=
>>=0A=
>> For the file system I've used XFS and device was null_blk with memory=0A=
>> backed so entire file was cached into the DRAM.=0A=
> =0A=
> Thanks for testing!  Can you elaborate a little more on what the test doe=
s?=0A=
> Are there many threads or tasks?  What is the I/O path?  XFS on an NVMEoF=
=0A=
> device, talking over loopback to localhost with nullblk as the server?=0A=
> =0A=
> The nullblk device will have all the data in its pagecache, but each XFS=
=0A=
> file will have an empty pagecache initially.  Then it'll be populated by=
=0A=
> the test, so does the I/O pattern revisit previously accessed data at all=
?=0A=
> =0A=
=0A=
Will share details shortly.=0A=
=0A=
>> Following are the performance numbers :-=0A=
>>=0A=
>> IOPS/Bandwidth :-=0A=
>>=0A=
>> default-page-cache:      read:  IOPS=3D1389k,  BW=3D5424MiB/s  (5688MB/s=
)=0A=
>> default-page-cache:      read:  IOPS=3D1381k,  BW=3D5395MiB/s  (5657MB/s=
)=0A=
>> default-page-cache:      read:  IOPS=3D1391k,  BW=3D5432MiB/s  (5696MB/s=
)=0A=
>> iocb-cached-page-cache:  read:  IOPS=3D1403k,  BW=3D5481MiB/s  (5747MB/s=
)=0A=
>> iocb-cached-page-cache:  read:  IOPS=3D1393k,  BW=3D5439MiB/s  (5704MB/s=
)=0A=
>> iocb-cached-page-cache:  read:  IOPS=3D1399k,  BW=3D5465MiB/s  (5731MB/s=
)=0A=
> =0A=
> That doesn't look bad at all ... about 0.7% increase in IOPS.=0A=
> =0A=
>> Submission lat :-=0A=
>>=0A=
>> default-page-cache:      slat  (usec):  min=3D2,  max=3D1076,  avg=3D  3=
.71,=0A=
>> default-page-cache:      slat  (usec):  min=3D2,  max=3D489,   avg=3D  3=
.72,=0A=
>> default-page-cache:      slat  (usec):  min=3D2,  max=3D1078,  avg=3D  3=
.70,=0A=
>> iocb-cached-page-cache:  slat  (usec):  min=3D2,  max=3D1731,  avg=3D  3=
.70,=0A=
>> iocb-cached-page-cache:  slat  (usec):  min=3D2,  max=3D2115,  avg=3D  3=
.69,=0A=
>> iocb-cached-page-cache:  slat  (usec):  min=3D2,  max=3D3055,  avg=3D  3=
.70,=0A=
> =0A=
> Average latency unchanged, max latency up a little ... makes sense,=0A=
> since we'll do a little more work in the worst case.=0A=
> =0A=
>> @@ -264,7 +267,8 @@ static void nvmet_file_execute_rw(struct nvmet_req *=
req)=0A=
>>=0A=
>>           if (req->ns->buffered_io) {=0A=
>>                   if (likely(!req->f.mpool_alloc) &&=0A=
>> -                               nvmet_file_execute_io(req, IOCB_NOWAIT))=
=0A=
>> +                               nvmet_file_execute_io(req,=0A=
>> +                                       IOCB_NOWAIT |IOCB_CACHED))=0A=
>>                           return;=0A=
>>                   nvmet_file_submit_buffered_io(req);=0A=
> =0A=
> You'll need a fallback path here, right?  IOCB_CACHED can get part-way=0A=
> through doing a request, and then need to be finished off after taking=0A=
> the mutex.=0A=
> =0A=
> =0A=
=0A=
That is what something needs to be done in the call_read_iter cached =0A=
otherwise with a flag otherwise callers will have to duplicate the code=0A=
all over the kernel. Correct me if I'm wrong.=0A=
=0A=
For now I'm populating all the data in the cache for fio runs so 2nd and =
=0A=
3rd run is coming from the cache.=0A=
=0A=
=0A=
Also, looking at the code now I don't think we need to use IOCB_CACHED=0A=
flag as long as we call call_read_iter_cached() since it takes care of=0A=
adding this flags which is a correct way of abstracting the code, than=0A=
caller duplicate this flag all over the kernel.=0A=
=0A=
Am I missing something ?=0A=
=0A=
I'll run test again and share more details.=0A=
