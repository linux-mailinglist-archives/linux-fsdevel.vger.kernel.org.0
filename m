Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846CA38F993
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 06:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhEYEbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 00:31:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28921 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhEYEbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 00:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621916978; x=1653452978;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Vltzk2LuETUa/y+e8noBqVk96ma2fbUsxJapsAAMhU0=;
  b=i+7wdcg4eWgkpoWxfE13f9Ws3QAwCPLSObrXqB9tzl5yXajTnvgGF4bC
   SPDzNbGJOUi28Umu0R7wElvei3F9K8G211I2eVJiUDyTUCIsVIh3jK7Gd
   BbDsLoLYz4LrwjwROplYqDZrC50prlxIVsrFole94nhusuo7847X0ulJ9
   yP7qyltLGbB6l1HKHNQ/z0LHJD1uztKeIamk9kG6iqEPd/tSkxwcCtL6+
   guCbCL/g/AgiJbBsLIfjXE2tzZVoHcSHkgc9JM0188norA0xbNCtjneN2
   X5jJcssaLNUgBX69OPouybU/3IiPm0pJ5e4mxxEuMWLgNxG9xqte+04T3
   w==;
IronPort-SDR: lVX40a3ESl6AlB4tCszfQ+oUSgnPv0Euh6qzMI0DZFYGBL1Yt7OSS+Z6rFO0IFLCzTl8uRWN4t
 HjXMrBcrxdPDbxD5S1CGZhpxsp0utnR6E6S61VVPQOzptViIEy8eaYhXjQEB6alK7JueE7z4S5
 qK6one25bZDk4Q6x7c5ZmwVAk0TGHZM2DJph3LNoIZxm6M8BLC3ogXxeYHJhoTbbfpMDKCdNe5
 HR9t6EjZiTIlQsAuYt/gWiWfQAlj1LhknL/2uxnuTEC7pwjgxtoit+Kpw11yaVaMLMb8klKS82
 6LI=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="168627042"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 12:29:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU82hknhTrLlH85T/NXAETGYwF1kgrkPrjAmAK8eXjNG5MeP+1S78wMZH4jjTFLm8l6UNalJ4klNlHfpNulfem50P5UHudBq2NCkk+rdZI5xM/l7wT2L/QTsUQepuAc5rciH5tmqS2VfxUUMcIzbyVb+7OKm3BV+tlGx3uLbSRpoNY1Mfz9fl4ARyrHwrVbRkUT6XeAGLwI3B2lr6wPerXBthhcwHhhFOjG4Y3VwpuVN3/HuOXE7fUJNQXlRl/IC1MWgDq1q0gIMgj9d+JfkX3PjqtpBj3tTrvYxlt6oP+me7gzTzD5XGQPsz/d0X6gGa7n9f5PPXq7kg5BMrPwyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW622VdDHMLnI0gfIZRwED9UEFjk1+KjwzbCejwC4Jg=;
 b=NFBwj7FmZu/zhT0adSoIXz3c8EBn4HJsGulGFXPHZ81tM+7fQWu48zjbIi+sHB1vDl9MxOExH9+PdeTCJQiOsV109ewrU+MY4isK2hR/crD2hEEK0IMde2rPRdB2tsHvjFSxDIfIV8zTXM1TczgjzdArwgveugkNDkayaw/xMcq7xoVvfYVo0qxHBFl8+SiMX0vCvmBQCVuvEeHG/od1dM3YyTRps9mOEfiVH7U/iBJn6UTKu7xHtlB6u+vayr6mQW7YfjXFejf6OH4KNbvG5By3TEZl9YxtGqlNWWH9MyQtAPryrlQHx71palN6Cfd5wHBbEQVSvJ9mLWXIbovEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW622VdDHMLnI0gfIZRwED9UEFjk1+KjwzbCejwC4Jg=;
 b=AoPgcu664dOfn1zH077zHEAemGqVw22JZRYUJDMJjwTpschfcxdi3a4MOwQ926Rv1sscoP3Hht17QHGLtOU3iSZWMxhxP7zkjslQVz08jLQRHvNjuOgNFWWEhtFZprwjXInU61VRrakgN89oh9bmGvShW7NAZeBuFYhskLUYa5U=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4409.namprd04.prod.outlook.com (2603:10b6:5:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 04:29:36 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 04:29:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Thread-Topic: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Thread-Index: AQHXS0CIxNdJAXZcBUi87HasJhE2QA==
Date:   Tue, 25 May 2021 04:29:36 +0000
Message-ID: <DM6PR04MB70818155B55E2FD7CE9D4D6DE7259@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-4-bfoster@redhat.com>
 <20210520232737.GA9675@magnolia> <YKuVymtSYhrDCytP@bfoster>
 <20210525042035.GE202121@locust>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:9d12:5efd:fc6d:4ecd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e963e5a-e2c0-4382-ad55-08d91f35b3e4
x-ms-traffictypediagnostic: DM6PR04MB4409:
x-microsoft-antispam-prvs: <DM6PR04MB44098DED49932D6EDA69B93FE7259@DM6PR04MB4409.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yw834DzvfTFWIjiqPXpijudJOc6jSD7Pj13pXMzN27sTgH0u4sRb70Gl53ztuLptviCZkpvI8Qrh56PflnTaSGHdHxw1+dzK8vDQJs99y8z7NhTo6U0Sf0bvRQd2gub0bbw2NNCMF1zJBqt5STimepGQUHPWZEpMnd7ODJ/9oTota0ATTjmq8BgFSLzch5yRxYu7rd+FasABxKtqVn3As5tqPooqWxlL5MtpVPGaDkoXnuFUJsOhVtKvrkC4jq1MhM+5L9ZtM3tzdIHpSFMNtdgGq18Mm+XQIk3V9yuvjQPEWZpml6gjMiMMYDmiREY+KBTiIxW/AQE4suY2FYLK+1hTor5XbEeF7Ya/oDlhqUeOR3Mb/RZ8KeDYqDMCXzct3QhHjoxcNlNQ3GXNC+m7yT9XN3+HPx/WRg8p3XF7sXPps0cnBfb3j7j2q5ikh4lBrAQaFx4Q3neoNTbi0NXEGE0IT2yv6KzPenKLbas1Q0olHGl5jzv3LfroC+ltAr/DlcISc5Trf9ItE0Bhd80onPeA/hvmBnGx3DvJT1xCFwHS2ja8vHs+toRFlwNMw5PrBcVSkdWNtHRWJWtYItEvEYwi3LH35n0mTGLGG9szVx4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(54906003)(2906002)(110136005)(38100700002)(8936002)(316002)(71200400001)(86362001)(186003)(4326008)(122000001)(33656002)(55016002)(64756008)(66556008)(66476007)(52536014)(76116006)(9686003)(8676002)(53546011)(6506007)(5660300002)(83380400001)(91956017)(66946007)(478600001)(66446008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7emq5eAL233purAVYQF6UvqujuOoH3HJ5IMXPVgk0Ptcb1OvgH3lM3KUH4lK?=
 =?us-ascii?Q?Qvqp/mGHig3WWubZWelwn7qNy4tECgSurrc0pEB23xKFINc44ieQc6vitaJl?=
 =?us-ascii?Q?w1HquwbZoQ/v/1QVq8AJuDzKPB9C/d3p1haIWOgIKKazU4xM8gsQ+uRk1e5P?=
 =?us-ascii?Q?KQrHvryHMGLHg5x2Y40uYvnJhj1wBZO/yHDYB/UxtXJW3RFvDlsZ9LCHLVhZ?=
 =?us-ascii?Q?p5zQWXQqMeT1A8omV2GTglTWHLoU5ZEUB4a7UYX4JvxFx6aY0Ols6k9zkYbH?=
 =?us-ascii?Q?LiHy5Am6bX94Kd8MPlpZUH581HSerhrQmRHzP1cWwiOZ/cbz6Nvqoi6ljq0H?=
 =?us-ascii?Q?wEaLWbjdxlvTOCaRFFpFeqX3/HKsdPWCM+Y/xFhKDCqewbhKlCPUsj9IadN2?=
 =?us-ascii?Q?1GpxP+JfYGgB/X6KIpdJdXBdPG0Yz+NsoalHqPUxzorcDh/BYEG43S8p69C0?=
 =?us-ascii?Q?ff8f37YRJpqU/Q9FWClWVtRGWaLx1p8LKaX74ZkdMBFmuYO7qgaFYChx11pB?=
 =?us-ascii?Q?3InfJqqmjoSBlDYT5qaMh2ROjebZWWCDBvMtwlEtd4nrIZhwL077oiims/4e?=
 =?us-ascii?Q?sni+jlSG18CmNX9olaNYe1O4in5bY5UHAZJIT1idWNDs4J1lLTjreARIHFhs?=
 =?us-ascii?Q?yy3kIsRbdzR8HDzLvN8heek+IVffwbVFbq7MoXUNzPaIiholfdJ3lTNxHw6R?=
 =?us-ascii?Q?z8UgxcKESzMHlcUsupqr7ISCjQHuRO3SHtQkkRKyc8/XkhC3JqyyolxiUMhq?=
 =?us-ascii?Q?56F8FXZjhPR91pgP9La+5COFNajx+vtkXPNSvS3WGYDoAaiZpjykL0TT6con?=
 =?us-ascii?Q?yySewORxX9hBM7lAJ5Xab9RyqJWAKNafBWCvIxgxJ5Vkw+lcS5oFzA4TJEE3?=
 =?us-ascii?Q?uczNVdqPIkz0ctUlA/j4hhSa2/zMo6tHq9SavWur09FMVpvKKN75tmyIHQ9j?=
 =?us-ascii?Q?qJpvbZDJkgOaXL6iOb84qq5P0LHQHSwQKttgeNT9gD8nqEVvykSii48DiC6K?=
 =?us-ascii?Q?NosGIBJC6i2sQxjI4JuY0n0A2J3KSF2A9y4qZXhJjgw3R7Y9iXgXX85GHHZy?=
 =?us-ascii?Q?Uv7rYEWnHlVn5ueyJyLZiVI21tzMLXrwdrav70TWeyU5gAAeEqPbxZGijJac?=
 =?us-ascii?Q?7WnnCLsthFdIRQ6Dv+9b9B+IlPLLmJUDNTrPW+iJ94ho2Hdl76Rr3H6rF6ko?=
 =?us-ascii?Q?GXeoaguefFIRuQ1zReCRCRq2qzb5szvsyd3r5bGmCDnc59kn/uzmDCxitrFS?=
 =?us-ascii?Q?y7IWua3/rSVAgrmUpJrncDjvfNTAY0nr8aQ63AMYOGqzFYfglKM7tqGbBEIp?=
 =?us-ascii?Q?U/pXsZTHm1cINSY72ixfEFvMQeGYCkINugaYDNoelN7/B4mOhnm56noK5Erd?=
 =?us-ascii?Q?DCIaiQ1lyuCzdvR0wEZLxT33VNAHL/C68ANaCb4GvstaxHhOXg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e963e5a-e2c0-4382-ad55-08d91f35b3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 04:29:36.0894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MgWpvyilLebH+SxiZB3+BI80SAX8GXIQojmwuh/l7JkZiTiyQi8BhXQGe/03JPiNdO3UeQX9i/ISdffmWB7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4409
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/05/25 13:20, Darrick J. Wong wrote:=0A=
> On Mon, May 24, 2021 at 08:02:18AM -0400, Brian Foster wrote:=0A=
>> On Thu, May 20, 2021 at 04:27:37PM -0700, Darrick J. Wong wrote:=0A=
>>> On Mon, May 17, 2021 at 01:17:22PM -0400, Brian Foster wrote:=0A=
>>>> The iomap writeback infrastructure is currently able to construct=0A=
>>>> extremely large bio chains (tens of GBs) associated with a single=0A=
>>>> ioend. This consolidation provides no significant value as bio=0A=
>>>> chains increase beyond a reasonable minimum size. On the other hand,=
=0A=
>>>> this does hold significant numbers of pages in the writeback=0A=
>>>> state across an unnecessarily large number of bios because the ioend=
=0A=
>>>> is not processed for completion until the final bio in the chain=0A=
>>>> completes. Cap an individual ioend to a reasonable size of 4096=0A=
>>>> pages (16MB with 4k pages) to avoid this condition.=0A=
>>>>=0A=
>>>> Signed-off-by: Brian Foster <bfoster@redhat.com>=0A=
>>>> ---=0A=
>>>>  fs/iomap/buffered-io.c |  6 ++++--=0A=
>>>>  include/linux/iomap.h  | 26 ++++++++++++++++++++++++++=0A=
>>>>  2 files changed, 30 insertions(+), 2 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c=0A=
>>>> index 642422775e4e..f2890ee434d0 100644=0A=
>>>> --- a/fs/iomap/buffered-io.c=0A=
>>>> +++ b/fs/iomap/buffered-io.c=0A=
>>>> @@ -1269,7 +1269,7 @@ iomap_chain_bio(struct bio *prev)=0A=
>>>>  =0A=
>>>>  static bool=0A=
>>>>  iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset=
,=0A=
>>>> -		sector_t sector)=0A=
>>>> +		unsigned len, sector_t sector)=0A=
>>>>  {=0A=
>>>>  	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=3D=0A=
>>>>  	    (wpc->ioend->io_flags & IOMAP_F_SHARED))=0A=
>>>> @@ -1280,6 +1280,8 @@ iomap_can_add_to_ioend(struct iomap_writepage_ct=
x *wpc, loff_t offset,=0A=
>>>>  		return false;=0A=
>>>>  	if (sector !=3D bio_end_sector(wpc->ioend->io_bio))=0A=
>>>>  		return false;=0A=
>>>> +	if (wpc->ioend->io_size + len > IOEND_MAX_IOSIZE)=0A=
>>>> +		return false;=0A=
>>>>  	return true;=0A=
>>>>  }=0A=
>>>>  =0A=
>>>> @@ -1297,7 +1299,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t o=
ffset, struct page *page,=0A=
>>>>  	unsigned poff =3D offset & (PAGE_SIZE - 1);=0A=
>>>>  	bool merged, same_page =3D false;=0A=
>>>>  =0A=
>>>> -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {=
=0A=
>>>> +	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, len, sector)=
) {=0A=
>>>>  		if (wpc->ioend)=0A=
>>>>  			list_add(&wpc->ioend->io_list, iolist);=0A=
>>>>  		wpc->ioend =3D iomap_alloc_ioend(inode, wpc, offset, sector, wbc);=
=0A=
>>>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h=0A=
>>>> index 07f3f4e69084..89b15cc236d5 100644=0A=
>>>> --- a/include/linux/iomap.h=0A=
>>>> +++ b/include/linux/iomap.h=0A=
>>>> @@ -203,6 +203,32 @@ struct iomap_ioend {=0A=
>>>>  	struct bio		io_inline_bio;	/* MUST BE LAST! */=0A=
>>>>  };=0A=
>>>>  =0A=
>>>> +/*=0A=
>>>> + * Maximum ioend IO size is used to prevent ioends from becoming unbo=
und in=0A=
>>>> + * size. bios can reach 4GB in size if pages are contiguous, and bio =
chains are=0A=
>>>> + * effectively unbound in length. Hence the only limits on the size o=
f the bio=0A=
>>>> + * chain is the contiguity of the extent on disk and the length of th=
e run of=0A=
>>>> + * sequential dirty pages in the page cache. This can be tens of GBs =
of physical=0A=
>>>> + * extents and if memory is large enough, tens of millions of dirty p=
ages.=0A=
>>>> + * Locking them all under writeback until the final bio in the chain =
is=0A=
>>>> + * submitted and completed locks all those pages for the legnth of ti=
me it takes=0A=
>>>=0A=
>>> s/legnth/length/=0A=
>>>=0A=
>>=0A=
>> Fixed.=0A=
>>  =0A=
>>>> + * to write those many, many GBs of data to storage.=0A=
>>>> + *=0A=
>>>> + * Background writeback caps any single writepages call to half the d=
evice=0A=
>>>> + * bandwidth to ensure fairness and prevent any one dirty inode causi=
ng=0A=
>>>> + * writeback starvation. fsync() and other WB_SYNC_ALL writebacks hav=
e no such=0A=
>>>> + * cap on wbc->nr_pages, and that's where the above massive bio chain=
 lengths=0A=
>>>> + * come from. We want large IOs to reach the storage, but we need to =
limit=0A=
>>>> + * completion latencies, hence we need to control the maximum IO size=
 we=0A=
>>>> + * dispatch to the storage stack.=0A=
>>>> + *=0A=
>>>> + * We don't really have to care about the extra IO completion overhea=
d here=0A=
>>>> + * because iomap has contiguous IO completion merging. If the device =
can sustain=0A=
>>>=0A=
>>> Assuming you're referring to iomap_finish_ioends, only XFS employs the=
=0A=
>>> ioend completion merging, and only for ioends where it decides to=0A=
>>> override the default bi_end_io.  iomap on its own never calls=0A=
>>> iomap_ioend_try_merge.=0A=
>>>=0A=
>>> This patch establishes a maximum ioend size of 4096 pages so that we=0A=
>>> don't trip the lockup watchdog while clearing pagewriteback and also so=
=0A=
>>> that we don't pin a large number of pages while constructing a big chai=
n=0A=
>>> of bios.  On gfs2 and zonefs, each ioend completion will now have to=0A=
>>> clear up to 4096 pages from whatever context bio_endio is called.=0A=
>>>=0A=
>>> For XFS it's a more complicated -- XFS already overrode the bio handler=
=0A=
>>> for ioends that required further metadata updates (e.g. unwritten=0A=
>>> conversion, eof extension, or cow) so that it could combine ioends when=
=0A=
>>> possible.  XFS wants to combine ioends to amortize the cost of getting=
=0A=
>>> the ILOCK and running transactions over a larger number of pages.=0A=
>>>=0A=
>>> So I guess I see how the two changes dovetail nicely for XFS -- iomap=
=0A=
>>> issues smaller write bios, and the xfs ioend worker can recombine=0A=
>>> however many bios complete before the worker runs.  As a bonus, we don'=
t=0A=
>>> have to worry about situations like the device driver completing so man=
y=0A=
>>> bios from a single invocation of a bottom half handler that we run afou=
l=0A=
>>> of the soft lockup timer.=0A=
>>>=0A=
>>> Is that a correct understanding of how the two changes intersect with=
=0A=
>>> each other?  TBH I was expecting the two thresholds to be closer in=0A=
>>> value.=0A=
>>>=0A=
>>=0A=
>> I think so. That's interesting because my inclination was to make them=
=0A=
>> farther apart (or more specifically, increase the threshold in this=0A=
>> patch and leave the previous). The primary goal of this series was to=0A=
>> address the soft lockup warning problem, hence the thresholds on earlier=
=0A=
>> versions started at rather conservative values. I think both values have=
=0A=
>> been reasonably justified in being reduced, though this patch has a more=
=0A=
>> broad impact than the previous in that it changes behavior for all iomap=
=0A=
>> based fs'. Of course that's something that could also be addressed with=
=0A=
>> a more dynamic tunable..=0A=
> =0A=
> <shrug> I think I'm comfortable starting with 256 for xfs to bump an=0A=
> ioend to a workqueue, and 4096 pages as the limit for an iomap ioend.=0A=
> If people demonstrate a need to smart-tune or manual-tune we can always=
=0A=
> add one later.=0A=
> =0A=
> Though I guess I did kind of wonder if maybe a better limit for iomap=0A=
> would be max_hw_sectors?  Since that's the maximum size of an IO that=0A=
> the kernel will for that device?=0A=
> =0A=
> (Hm, maybe not; my computers all have it set to 1280k, which is a=0A=
> pathetic 20 pages on a 64k-page system.)=0A=
=0A=
Are you sure you are not looking at max_sectors (not max_hw_sectors) ?=0A=
For an average SATA HDD, generally, you get:=0A=
=0A=
# cat max_hw_sectors_kb=0A=
32764=0A=
# cat max_sectors_kb=0A=
1280=0A=
=0A=
So 32MB max command size per hardware limitations. That one cannot be chang=
ed.=0A=
The block IO layer uses the 1280KB soft limit defined by max_sectors=0A=
(max_sectors_kb in sysfs) but the user can tune this from 1 sector up to=0A=
max_hw_sectors_kb.=0A=
=0A=
> =0A=
>>> The other two users of iomap for buffered io (gfs2 and zonefs) don't=0A=
>>> have a means to defer and combine ioends like xfs does.  Do you think=
=0A=
>>> they should?  I think it's still possible to trip the softlockup there.=
=0A=
>>>=0A=
>>=0A=
>> I'm not sure. We'd probably want some feedback from developers of=0A=
>> filesystems other than XFS before incorporating a change like this. The=
=0A=
>> first patch in the series more just provides some infrastructure for=0A=
>> other filesystems to avoid the problem as they see fit.=0A=
> =0A=
> Hmm.  Any input from the two other users of iomap buffered IO?  Who are=
=0A=
> now directly in the to: list? :D=0A=
> =0A=
> Catch-up TLDR: we're evaluating a proposal to limit the length of an=0A=
> iomap writeback ioend to 4096 pages so that we don't trip the hangcheck=
=0A=
> warning while clearing pagewriteback if the ioend completion happens to=
=0A=
> run in softirq context (e.g. nvme completion).=0A=
> =0A=
> --D=0A=
> =0A=
>> Brian=0A=
>>=0A=
>>> --D=0A=
>>>=0A=
>>>> + * high throughput and large bios, the ioends are merged on completio=
n and=0A=
>>>> + * processed in large, efficient chunks with no additional IO latency=
.=0A=
>>>> + */=0A=
>>>> +#define IOEND_MAX_IOSIZE	(4096ULL << PAGE_SHIFT)=0A=
>>>> +=0A=
>>>>  struct iomap_writeback_ops {=0A=
>>>>  	/*=0A=
>>>>  	 * Required, maps the blocks so that writeback can be performed on=
=0A=
>>>> -- =0A=
>>>> 2.26.3=0A=
>>>>=0A=
>>>=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
