Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5461928ED82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgJOHVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 03:21:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51090 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgJOHVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602746503; x=1634282503;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AB66Hf51U99go6hufViO2OR3Owm4L/fmfpZZ8WW60SY=;
  b=HfTi6FW200D6+tlFRv5soBxXAMuDpo5wP0q9G3zAf4jFjdsoN4hFR4W7
   7n3GJBbM7XCgqCQjZF448cKS7PktY1fXL2XuBcM7CPFIV5d0xhRhQWLC6
   whOSzlZbbd2sfFqSlOhf2/RMvBC3rQJByq4Rf6KZRdTOI0xL09G9nraPl
   n5WBzzgFeKjdC/kNpJ/0WE9B553MTdhzB/E2yUbIvriRsJ2NFeJFV083o
   4Q2yah+C/2ddOziMclbIpSskAGy29dMTP0o00kRTSS3wlablUQibbm1TV
   r9KzvCNQTh7LVLSQTtv0dpO0kIvXHK/fy45F9RcN+1mHZwSqQm+fWNvwv
   Q==;
IronPort-SDR: QFjrtRMA49Ev4I6HD6A78Cw3oEEkqZ/MRP0s5/mrZEs9H2iSrQSxvTV/Jhon1XqFSq0fJB2ZuK
 yc+1Ro1ay4HaODk7dyHV4DMueDTvMrUHK9/af1rVWHLTVFMSiNUeA8ZSongU0yRi00rJ/fosQ/
 mEOnWYEaYt/jzSwD8a7928XXvAOFH9qzM+ol9w0Yq2Uafc9KUVN4lk58KThuYbY6msh2bd8zVn
 AwRUYQ/leDigdWDGJ9TqmGNhISQgCOrM4jJPr5oUVLybIMXWRL5djPDgN75Fij6y7cWrc7qlE4
 RgA=
X-IronPort-AV: E=Sophos;i="5.77,378,1596470400"; 
   d="scan'208";a="150003106"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2020 15:21:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfXf/QyN1+/dOyp89+C8YUyWl8fQVp6J29InqXtj8Pdw54WAimtvIcDTzFCKZXW3lXwvSJFKVVJ8iTVQj7jv5DDU3QM0gF13uHb5/eL2J10eH0W34EuK8A7hA3JHHm9CV6nhDcapJKimbhms3r5adORkj3EyRnL2K69dsPxGxYc2rriDb2CF7TingzbZrFF06S7s2SNw9Tb3CHmETF4rNwzVz5IsLZbHC4n91sW/3XFovhajVtlr1n9L5AYcHd+pAlpHbJYV5y/RJcQAu+tJ7TKA9DDynyfOV2IlYE4MaRk9Y1YRMagcH0NpBOR0UlseRjVRO6et5aHNow9MbGs/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl0vv98bVxf1gVTOfW+dSDGnPLoP0m3uHrLny2RaBVI=;
 b=lMUTwccbzHIYcM6+RkFLd4ZXlKNyJ00qq5pD3NQr8jFujT0meTQ83pKArs76YZCxxA+Td5y2kvxT6TQadFC0An7ypaHv76LQ8rYmsmGJnYSIXFKKUsLFFf6ghcrnj0WlFUMsta2g51tUAahvLCwsc8iHHAOJHmqFCjgZZHsNCifP+Fm20izXLFQDtQaCyTbjxk2ggbBcezki0xa2Nr0bfsiHhwxjo5v4Gd5pfTpm1FHEoDjaYiQ4x+D1AuXvWxCGF2Wt/w+INOPZ9M7FQpb7crpVhKADdD4oEjEO9bQ+26+3jOb0TA0796I1rnlC+GeoVKG4sO6xom1fMpPfE54ynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl0vv98bVxf1gVTOfW+dSDGnPLoP0m3uHrLny2RaBVI=;
 b=DysqSbL5bo2JxkELl072Yiq5Hq9c7KyV3CsxixnYN5k5Z0B+gIQ8M/rDAxz9QJNuDg9aCrgWZDvKxpsEAkreBzuZte+j68T4Ync0dRTLUvZ1JBiA3GfQ0uj8olQz0NTU8ap/YlID50jNMMyx+gLRi3oh0wQBNexuBGNhJJRxP/E=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR04MB0236.namprd04.prod.outlook.com (2603:10b6:3:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 07:21:33 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089%7]) with mapi id 15.20.3455.030; Thu, 15 Oct 2020
 07:21:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v8 38/41] btrfs: extend zoned allocator to use dedicated
 tree-log block group
Thread-Topic: [PATCH v8 38/41] btrfs: extend zoned allocator to use dedicated
 tree-log block group
Thread-Index: AQHWmualXUvEPCjN8kGJwAlSdsakLQ==
Date:   Thu, 15 Oct 2020 07:21:33 +0000
Message-ID: <DM5PR0401MB3591CC65C5B1E7EAED1C5B069B020@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <17f8b62a6fc896598378ecf88bdab5f6b3d3b9cc.1601574234.git.naohiro.aota@wdc.com>
 <20201013162616.GH6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6528773-a6ac-447d-a80a-08d870daf201
x-ms-traffictypediagnostic: DM5PR04MB0236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB0236026F0166D431530C623E9B020@DM5PR04MB0236.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TaZcGFvLu1jDgl8H0VYeMASJXOiiHqeFJygXO3Wf8g1kOmwW34eVeMbW7D2TEVCx2DENbSFSyz3sq0EnD8mzf43YvaJMfaFeDgT+tcYqsXBu+CkJVDbCEhxW5Uylu1MDKjHoIPjlmPFk9WGAlbOqhf4vRt/sQXh/3MV8/2kkcNpLtyRb5v+eUTRBFbTwGE9FnW1pAC3OXXx+Ku115HjduMyTaJK+Ehl23nEk5rmUU4NRWvJvTvrb7C5+iwEgCwjxYNqhMq0DULJQxAzc48j2jrnw+ceN/ktEgBynW03hxZlZT9M/4IneVkWH9J3iWh8rrDTau9C1YqZAe0X08mwEBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(7696005)(5660300002)(55016002)(76116006)(66946007)(2906002)(66476007)(66446008)(4744005)(66556008)(64756008)(6506007)(53546011)(6636002)(4326008)(478600001)(186003)(91956017)(26005)(8936002)(33656002)(9686003)(86362001)(8676002)(110136005)(52536014)(71200400001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: duAFN/+zOm/tX/+gtcZQ7yU18QiyhSdh94MO4Kg2toxKJaY74bcSdFfn7zy/GTdB5AOpRx/CABLl1aZM8PEShoWUd6SwdCXdGM8nMRHBXqRDOsDd8UvkQTwq7uFXOs8Z29187fST1+vwfqrXttGjCoKvlMH6ynEJr3cXxxAC5JFWD1frCnI4AYtbMs7AC5JxfUc/emTx3bL83F9mJAId4aOs1FxSFwLLiiwvWmxkm3FKMHwkDmOXEfs33+vw8ApWTWsuInYmPqObLeHICCn8Fmlf8VTAM3cGenXMbV+NZeaW6Fch1+fZgy6vYdMYUJvvcbkBH+bbI0kxUrMhh+5ig+fN97DNF4T3Mk0nGenzZxAr2PW/S/ExQkuDe2KN6sDYwI5RSf/21MNekMdkfNqmc7c3akg5/XzKqWLWKcDp9or+g1z0yt81YqLT7HRfsG8+cvI3+jgBbWakUeFOsrfwUtjKtUDfvDG9/5KOBMOqJwS3AaLSAP/Q5xypcmXDriY7hWzS+fogq/RgbyaDUM2rcw2UXp+XlIHOgiM/eiAeLJbuU2fujol/R/4xg//y2L7WZCYocnzv8BaZ5w0CShB5FrNA/KrVM41lq3S3vYKteqb6+QaEf/wbpfIgTTXdI2OgHR2q4LL14XiSZiNJBEI2AA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6528773-a6ac-447d-a80a-08d870daf201
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 07:21:33.6622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BI1eL7xStu8Nm3Da/iPKVKDLz0y4rV2nphlKADm7/mWh4kxQxk5utOTDefLmNV/oIJBtKqpKWRal1P/+1ejXUQrxWrp3NMEQK3tWVYAKs/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0236
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/10/2020 18:27, David Sterba wrote:=0A=
> On Fri, Oct 02, 2020 at 03:36:45AM +0900, Naohiro Aota wrote:=0A=
>> --- a/fs/btrfs/extent-tree.c=0A=
>> +++ b/fs/btrfs/extent-tree.c=0A=
>> @@ -3656,6 +3656,9 @@ struct find_free_extent_ctl {=0A=
>>  =0A=
>>  	/* Allocation policy */=0A=
>>  	enum btrfs_extent_allocation_policy policy;=0A=
>> +=0A=
>> +	/* Allocation is called for tree-log */=0A=
>> +	bool for_treelog;=0A=
> =0A=
> There are already bool flags in find_free_extent_ctl, move it after=0A=
> orig_have_caching_bg.=0A=
> =0A=
=0A=
Fixed =0A=
