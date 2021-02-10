Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E48315FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhBJGrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:47:31 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36766 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhBJGra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612940789; x=1644476789;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4hXt2Zzjr1otYz/wWyovjgHo1JquIeGCRDMdKWexnQc=;
  b=dRNipSYApSdlsSfn5ZWNwg+X/Lw757I9ivl8evXUXlkuKhEHXfXpVJr9
   vrBf6fT4axDbZHroN5eTtCsSd5amF/Kijndv8ItgVi+8nLpfK/QyOnH6v
   p+7BBmHJd45eQdSd0rwYZfCNuwelEwtSSHO3BNoaaJONBoA8i+21izf17
   S2b1BaAF4WageYhfL0ogK2HKTKhCNF/RtMZ4UtoedWbtEq1AVgc9rjehm
   tmbEGqnut3PJXFjj/Lnm92ywwY4/AqA+AwlMZRXfllqQuOElCC6yeOM0Z
   mTnVb1iZy+juKh6n8mo+NG1BaYAzbgtadardXzM0khq1jsUXInNILFnl+
   Q==;
IronPort-SDR: uD2hSc2ItRI71onhqY62exjH0y0bdaNfPgdEwPeR5hcqatYTsDsq7c+sAjNOoeH9QO868dszjX
 H/65l5YNOnX8hiLeV6yU3y9zEuILsvaTzyIPE3wNDi3KP/aSTGXrG1cSeFowm30rTlWb0tRpxS
 4RYlTuWVnZOCqYx8n1VAc1yI0Ibwow78gq4ACICqu9il/xQ9hITBN1HYHASYR6sTW60pPdEWS7
 9b5k4Als6Ie/Fum9NpqA5h4YWyqHmCmq+PXPdnJzYitrwAJmZp7CT9gJ6Dw+HWkxj+gvb1BCv1
 N/Q=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; 
   d="scan'208";a="263728647"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 15:04:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMwHr6/hsUbgEL+CYy75u+r9gcNk7/u28AuKGoGlNwwWPiHCnkCHnkqoWv8xYW7fbb9PB9CA5oA8oqDYlsBYdExGszr7a9arCWQiL+fIIuVTC9ABq+mp27qQ1dCrbIh1AclOj47L5oOddj/Ul0CcGDkgtgQf3X6mCPNm+przrrvCznjZb3kYbTf7S/qhIj9LyGooJD0IgtUhuWB+u0j0dcV+quOw5iv4PlPulGah4+OI7aoakYDkajF46tUeEaI6pt6mLX9QAkmvWQ5jppEStXROZdBc5qI4afht9kJlyaX28QkakBLM5bBybkQpLw0VsA9s3wwn2GL2n8UOPvrhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hXt2Zzjr1otYz/wWyovjgHo1JquIeGCRDMdKWexnQc=;
 b=B8OEAu5gj0cHnuf5mebUUt7c7uUttjhPA/zuGFbMDWUAHm/JyFnCcO2EX1pD3gsx0OzwXmRUcx+Mf1CRVMcxWxZ4Ym0+WSJaabetoFoeIroUzLM9KRAyPxUVQ4Xaz/U6dNnqH8uBaoc64mqWxdLD72rmptk6BHQjkZ3cqGxWi7HMXRV33qPbIiaMTUfXiC5D74XwnVIzGG/f06GoEOGdHhDlVAZ6k2v9LYalC/s5I1INoxJufbLZUJVwLBh8dIjtC0hvIspwNx11I7Fux7tEAsZHfhVGf19/BfhLc1bQY6ztIEHeEBefgvAn+Y6hcqcgQtLIYnGYK87ucdesA/Golg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hXt2Zzjr1otYz/wWyovjgHo1JquIeGCRDMdKWexnQc=;
 b=CB760COEC9JoNQeF4JrrY7dzEXjKPEf9TCUyEPrbxVynm7nP7xCFaUyAlLZ4wG4byb7Q4fwd/WpZC5XaYzk8dslS6ZfzjKnTORoVxBkQFB7X6cXOCYHhNrQQjNFIzcLMmq4OukyXIT5ZxxJFg9hLTvt5k5Vfa4SsCRRl/vqsolM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6898.namprd04.prod.outlook.com (2603:10b6:a03:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 06:46:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 06:46:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
CC:     "hch@infradead.org" <hch@infradead.org>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 3/8] mm/highmem: Introduce memcpy_page(),
 memmove_page(), and memset_page()
Thread-Topic: [PATCH V2 3/8] mm/highmem: Introduce memcpy_page(),
 memmove_page(), and memset_page()
Thread-Index: AQHW/3WCofnRHeK5gUam7rAhVHmE+w==
Date:   Wed, 10 Feb 2021 06:46:22 +0000
Message-ID: <BYAPR04MB4965443B9392BC36AB8F2CBD868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-4-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb7144a6-a57c-444c-a716-08d8cd8f941a
x-ms-traffictypediagnostic: BY5PR04MB6898:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB689839F0C0E1E26811AA8D76868D9@BY5PR04MB6898.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: suAc5fZAIupcYajAzUcgKJPXl9I7l665KzFbAurCU/IYGZoRL1yd6mCL7gEeB17WIAMIWYE0MH4X9pMI72ty0/jIvxtml4EuyE2iWrA2Ic/lFFxFY/m/HEibwRLHvSUBLrCWXgxWfmSfsqWHZO4gRzARYHRO3I5m04zCIDhV5l/B6ts6f+CBBaGgDgLLbFbRNUvlygWFJdlNvNhTnF+nf0QqAPFvHjLHqEBYjXI0tHFGP/h6QQagNeWDujBKQh+ZdmqKWY7dzYJ8u//XBzByywJWsoMKMPQUpKFI0i1nP3p2+RB8Yq0Nr19uTu8xzgs2tnCYAObyiB6MUgu5zqnFJ85Yk67G6zTw2aBem+w0Zgn7ZRvrZLlcdPYjsO2xzSlmXBLb85ptdUSVNMode0aqsW4d8E+a8GctvkjCsUCZUv1fyuhwCQScdkiSqJIN4yMEZk5uYUjuQi9rA+e/U0pIYxmpQ5O0bGDXp6ZdmvY0shPaOG5I9BEaekHDg8Y9KIuUeIYIoug/2rDAdyinJDri/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(86362001)(76116006)(55016002)(478600001)(66476007)(66556008)(64756008)(66946007)(66446008)(53546011)(6506007)(8936002)(186003)(8676002)(26005)(71200400001)(9686003)(316002)(4744005)(2906002)(5660300002)(52536014)(110136005)(7696005)(4326008)(33656002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SP2kyt3xvHJ6rr43U+bjbkbqgZORsfSS9sdcCElrw7OFsMFM6SBk6dTgWzaU?=
 =?us-ascii?Q?wBZjbejaszDp1USF6EU4p5vpr2V7sU+5VFx0uV/PsILFn3sP5i9ue9uSSpJ7?=
 =?us-ascii?Q?OKOMHzamBT6UEM83jCEFfLw3bhyO5p3MO3VgpDhWE+z+U9PuOIGi5RFV8hDp?=
 =?us-ascii?Q?RsXjx0SwFtKOweKVq8d1I0fMw90lrXZ8qNRrxRB6cjfcFoGMq3OHJon8psA2?=
 =?us-ascii?Q?URqUTD/I4mh7Gc18xgXgvNZv1E3hqTpRb8tTCMGTzLgRk4P09+omJ3BFXwoB?=
 =?us-ascii?Q?+Eyz34cVLAj2QwFKsaxwE270j9f0cKoAwpTA/QlFptU/PASTQTm92V1APx+H?=
 =?us-ascii?Q?stxj+ZdOElS3aCw5Lj3MR7Onocu7zqxBiNSIf4DysB1nU0r9nWebIbDBftCi?=
 =?us-ascii?Q?EOkp82St77Uw2ot7Rgzoj6ztIMmwQFCAa+n68ak8JZru12IJqkQbfpNCP3hH?=
 =?us-ascii?Q?E4PKqe5PlKJjX/Em9sjuQhBk89WK4Tk8dgo9R0ieD2SZqB1iLtYI50QjwIEa?=
 =?us-ascii?Q?ivqhJv0VJndJuqml1PrGcN4A4jigKagxEf0nVEGSY7oJvVhTSkXLR5u+/Wn6?=
 =?us-ascii?Q?ARGco0wl8xOscDJytS+E/IDKpqxLpvu166rd9qFPq2ym+b6diEFEkuB6jKCY?=
 =?us-ascii?Q?JPobYmN+/DxyGjFvLbmLncUc84K4mTD+4Mm8u01O1clZ/sBEQTmAsnow6EFP?=
 =?us-ascii?Q?8RrIJtYQ/Usb/4/5IR4ZTk70QhVOta8Nhf56Q+uw2sy4iVhgy64rHQiMqcJt?=
 =?us-ascii?Q?PAifOvVT3jEkuf0wkqFoc6hKzGE0orvONZqHREK4aO3IG9DsaKl+y1G9Oy6O?=
 =?us-ascii?Q?7oMoVX5qHsGN+LHLO0P0QbwoTEBkT4ZgjhUfNaacFoaQpvbNiXVvgPwYZ5IL?=
 =?us-ascii?Q?gvrsWS0C3oMEGAdFamP6iw0ULo0Cre6408qR1qz+lCpFAtHWfeHLdrzJPA7y?=
 =?us-ascii?Q?FkKjj4nfm7JiDXR+4zUDHqVU58QRSKw8tRGpr1nOZtNFO+BX7IFtLGyF4jWd?=
 =?us-ascii?Q?tUkR/Gj5VfFr36cfr+XiT+1CTa+wO4wTxV5htZ1Zq6UuDxgRWB9eFqIfuyFv?=
 =?us-ascii?Q?0i79FGEhGPedEWiq9mnSkhb/+6b10Q3xPuiit0iNZxzcC7BJOqr8/N8dS88K?=
 =?us-ascii?Q?Mwyc0evcDgfLbbL2AIJiiOiBOjxFM5IEgltVoKBkYeljwR/rufPe/wlvJ/SI?=
 =?us-ascii?Q?jLPkbMbYqtW4soc4mqJmQq+s+8y6FrlUf/NgCB+qKVyrUqLb5eMjiSbFEhEz?=
 =?us-ascii?Q?hf+sJBS5L+djAwXp6NZifFo8WLPjY3ouLPY0SktchSPxwrK2GxEt3gGJAUy+?=
 =?us-ascii?Q?bTiXJFLZnC0Z9ijaNPeqiR/E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7144a6-a57c-444c-a716-08d8cd8f941a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 06:46:22.0997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bUa18wmGlnJJZ8rIL2ijItbPbGYgqmtXcwd9M9K6gWaKKB7M5csRHuPv6ZhlpT41M1/uZid9Fn0FAnOaxT3ifvDQCsPuJlxRUlRcLeCCVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6898
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 22:25, ira.weiny@intel.com wrote:=0A=
> From: Ira Weiny <ira.weiny@intel.com>=0A=
>=0A=
> 3 more common kmap patterns are kmap/memcpy/kunmap, kmap/memmove/kunmap.=
=0A=
> and kmap/memset/kunmap.=0A=
>=0A=
> Add helper functions for those patterns which use kmap_local_page().=0A=
>=0A=
> Cc: Andrew Morton <akpm@linux-foundation.org>=0A=
> Cc: Christoph Hellwig <hch@infradead.org>=0A=
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
