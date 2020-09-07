Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6C25F1FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 05:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIGDJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 23:09:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64112 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgIGDJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599448164; x=1630984164;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=D/NmT6bsxjyYGs4N4W+I2bBRCUc/LkeRzR8OdS/D2mQ=;
  b=RmiXjJKXECVypydsLns2UbClnJMTIDe65PTx0VJPnLgqYWcaQqcT+s8t
   K7u6IBajfoXkOJoH6MhGuxpKIS3RfIBHoEsVTU9+RuqS1QnmnVarbw5IT
   bc8dMftRoqacdDxiGur/eAJRmApsC78oLacee3MZS7JYGv6kk1Ue6SBXm
   T1pUfIfsqABIip65+JOI2ZVgnEihdNg4p2nAOQxu8YjSa3bsIt9cMwD7H
   jSnM7D+uWijqQbgK/HAKYkJbFeg2lYfnmZGmCsdb9c3YMTcjJdz+1ozwx
   jqMxKIiYOusShHlyG3T1o51UTDYfaIxHrj/lGcEBTJH3Wu9V5mZnJ6vW2
   Q==;
IronPort-SDR: sUutWkF04HnsaSBJbSWxLtzwy/4v6F7xOQbwaZ5uTkv9nM6uEl3pYXLsGjxd2QJrc+mmenl0v0
 XSh8YcR2ovsI+jCH9xavkQ4kCd3SpUJ8GXpcXuIIEKZkOLg6a9k219kZ+RcghVO8Uoi4F4aZ2x
 WfKCPLNGPXtQNZoAKZn242YOKzks64ie3zJAPc2EibKf+sonH4foaOraYf8Os0iqNxhdOuev5R
 JipiLqNV1zYzmUx5v4qPHqsVTH+Fd5F1rcIvkjHQWdzXEInSDdAvxnz4XPfdPTD+kJ4PjhFggk
 /2Q=
X-IronPort-AV: E=Sophos;i="5.76,400,1592841600"; 
   d="scan'208";a="249991389"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 11:09:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM1gtfs6KuOU70zvPA9ez+nUZRyrZbtetrUotWJv1Q++RJG82GCr3tZlWh/GniA+smCDDZBz6ZUP0DdW278rocyVtT7+r9qj9EcBaPkN4WfkggrXsm53TC5oyzaYMmVu74E10cWqogM74LURdSFv1kR3uT1gNgGK8DSZj6yZ4b0HddVGbpJ/Nw6n7gAOZFSUlic23DP/EIQbEUGfIhZw5IlsNbdn79AmOrFPD6ymIhiJQ91ieSovpA3DkOetleMEtdHLM8Fpc8JaQr5hVAe7+iR9h31frUlAhMzevCnQHa/ruyxjCqw7FYrpHkk6DEBDlVkRHs2rLvYhw4CoxhULfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnd2cgSUe8fjXAfpMnJVSB0RJvcgsM0MRX5YZLBcPnQ=;
 b=eMtoAW6bq330Jl3m1GQzAMMz/sqdGt3U+yyTwvyENNgIkNcjWLU2ExoZ6MpB9LHD5/FBr0SgSkJ/oRS+avOEfriSX+JRxPl8itULHbGHQAdGWBim1F08+ICUIfmLRKwKrJ8vhyIx88EvxbzfB+fJrpZv9YepA5zbIwaWKCgQc4RbPs9fGGEbv1bnQzNriMO+s8J/dAYWs4rnr9G45NJ31OqBdQfp0k1MLtX7iwinzqBNlSR8luuI5i3VR4Hd+PF/vG09hks1d3Jyu1mDMVoIi+J8yowWetuRuVLI9gzXoDehLvjjSUDC/5AXL/P3NaXOosAf8MDOeeHNrQyrpevNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnd2cgSUe8fjXAfpMnJVSB0RJvcgsM0MRX5YZLBcPnQ=;
 b=Muc2/k2Y2KZxo6rVh2T/kQloRmT91sG3zICdAkNnzuVIQTCj6p73mx2/pGEkPMNWy2OeB0Ex+cd+0qh9Kbnk/UV0Cx7ip/rA6fb8zA8T1iwf0M4hIvvzQejZ5HK8HJ9aseWgR6Y+fr+UWBdZjujyZtsbhZgxlAuP0pdb4sB8+bQ=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0760.namprd04.prod.outlook.com (2603:10b6:903:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 7 Sep
 2020 03:09:06 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 03:09:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/3] zonefs: document the explicit-open mount option
Thread-Topic: [PATCH 3/3] zonefs: document the explicit-open mount option
Thread-Index: AQHWgq3XGU0gxuPOQk+964Eqyw8AVg==
Date:   Mon, 7 Sep 2020 03:09:06 +0000
Message-ID: <CY4PR04MB3751DCB8ED083F6D94BE037DE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
 <20200904112328.28887-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2cd0:86fe:82f2:c566]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f310f348-56e3-4855-6d14-08d852db61a3
x-ms-traffictypediagnostic: CY4PR04MB0760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB07608CC663F9D30BB3B22AA3E7280@CY4PR04MB0760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OhnG/TI53WK56owWPdE1BgmHW14KdJBfeK9GDBfxBSW3BSmdLLjkd5CIsbh+r3iPBr2NlXxQPgc2IqMbGAxLUMkbSf4bFoKQmPueVNcep/lpHIGkMs+XOSh3baw94q5qP1ff3bprX8tRrMv3aFYlstFFD3LsNcf/mfSXBpDMvU3Aoo2stChdZT6lIv83+yQd/J3TWiyLL1k6VwxTNDoyakCbzARBN7EuLYy8ZWKKPcPJxKokTsikUMXynb7nK795S/JINzqOhdbmJDv0Z69SJpvpC9VRx9iTPYdlp/jn/6iSQhpYJ4qRnrKHOCBkrqRl3hl22xO7qLw4Yf9FXV+wFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(316002)(76116006)(186003)(6862004)(53546011)(2906002)(91956017)(6506007)(66946007)(64756008)(66446008)(71200400001)(66556008)(66476007)(83380400001)(478600001)(6636002)(7696005)(8676002)(9686003)(55016002)(8936002)(5660300002)(33656002)(52536014)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: W6tmx/D2iTjEF8gsbsiNINp1RA/wZXduExukD/DQEACBnG/UWrZA7YQDitCjT1/pPhuWzx/hKqfr8EFus60GDNs9mUzuMeUZ1u1evmEh4GPRO6OyGhRf/XckNzM6nDiNof3FmhgUMFfq1uI+BfBQnRoS/5s4gKNuMoP/V57K5UouhVah/HJ6yavgBbgsCBs869LkUCBeViMiwMosvKWX3AEa2hiet8DvqTKjTwi6y9KjDsBPCjLPLS44tCznv53y/b0iUf2HnDU172OA/VbwLCyWKvz/FBJNVkgl6YuGR4a0GFcaiST5ZABTMzfS9SJDhVbNCbOaXlVyZ866KlOk8I8acICBK+5ZT/ase7Rhx8Fykg2XXud7NwF2/6rzaXZ9XrJAEvtLsQelyvE2JAQxYFj9HHtxJtEYPqT96tPTtzc4MTSE1xGfq8BkeBS/QtfFQjT4PwobRBhxl/jkqzi7iOSnM5nrygfMHX4ejSshQF52758YgbI2/r2YVX6N1JEZIWBcOK1hZTTzT02GmUN221kFdHWerC+rXdWGtwtMGgLv4HtaTxeWr6yfYj3kEHU7ZqswrtsX35Oy01NU2PdUL6rP2REK2CRWmt7BoAq2tPVJXVZXWH15BjgN23fAF/kQii8a3Mtyvzco9D/rIJ8hWzCWpQo5/VjNoYKBQRw+jg3CVYdkpCDQ3V7MSesSOIElsbB8k50I9iT1jCXeGagZTQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f310f348-56e3-4855-6d14-08d852db61a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 03:09:06.1421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CsvPpOpYC5YNcXqoowZAQvwOV3TPs1e9xltAOKtXBzDvdbDP6Ss7DDfgqgV1zHeRGx9dJ/ljJXQl+O4eJRv8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0760
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/04 20:23, Johannes Thumshirn wrote:=0A=
> Document the newly introduced explicit-open mount option.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  Documentation/filesystems/zonefs.rst | 15 +++++++++++++++=0A=
>  1 file changed, 15 insertions(+)=0A=
> =0A=
> diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesys=
tems/zonefs.rst=0A=
> index 6c18bc8ce332..ff8bc3634bad 100644=0A=
> --- a/Documentation/filesystems/zonefs.rst=0A=
> +++ b/Documentation/filesystems/zonefs.rst=0A=
> @@ -326,6 +326,21 @@ discover the amount of data that has been written to=
 the zone. In the case of a=0A=
>  read-only zone discovered at run-time, as indicated in the previous sect=
ion.=0A=
>  The size of the zone file is left unchanged from its last updated value.=
=0A=
>  =0A=
> +A zoned block device (e.g. a NVMe Zoned Namespace device) may have=0A=
> +limits on the number of zones that can be active, that is, zones that=0A=
> +are in the the implicit open, explicit open or closed conditions.=0A=
> +This potential limitation translate into a risk for applications to see=
=0A=
> +write IO errors due to this limit being exceeded if the zone of a file=
=0A=
> +is not already active when a write request is issued by the user.=0A=
> +=0A=
> +To avoid these potential errors, the "explicit-open" mount option=0A=
> +forces zones to be made active using an open zone command when a file=0A=
> +is open for writing for the first time. If the zone open command=0A=
> +succeeds, the application is then guaranteed that write requests can be=
=0A=
> +processed. Conversely, the "explicit-open" mount option will result in=
=0A=
> +a zone close command being issued to the device on the last close() of=
=0A=
> +a zone file if the zone is not full nor empty.=0A=
> +=0A=
>  Zonefs User Space Tools=0A=
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>  =0A=
> =0A=
=0A=
Looks good. Please resend with Randy's comments addressed.=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
