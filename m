Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4811543AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 13:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBFMCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 07:02:16 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61035 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgBFMCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580990536; x=1612526536;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4yzU60TmH8t4BUYBiS5V8mhqCIlTP4mYoPJGMTaT8co=;
  b=HJ9rYlHr3W5lfwRaDIyf0Zq1uOhGytf3J6X3M4dN4JejnORMiQoptoO2
   IRDnzrd5yVSI8IsRlcPY8mk3AXyRJzTDvvtCKCoSwykBdB/6zpr0KRlYD
   EHQuRSDpoLlihzo1xV/ZcAp41K7ia7EqaWekK/2oSKauys5WFTWIrJGts
   dDA2IPAVnu6/cxQzYuSwTLyJDayXK1aDDVne2XnIyutPoYDFZoc/8YgHL
   bd7lPHWjC/preLcaOUSdOvTXrw4/DN51WI91vb0/oJaIJSosRiMy9E8vm
   Z1o4S+MISEhCEuPEBFalGVb6BHycAHljfbrr4S6J2etZvkWgbo0nMoDUA
   A==;
IronPort-SDR: y0i2aZpc5QAdTc34uxHXGqpUiIPwiBxJgnBoArjRh8h/iHHqs3hMcGeXmtdcgCjxK1D0U1YP5m
 Pu2Z3wAo3JPRWa7DxoFBITTAbiPXeCY88AtTboOKIRo9galDL/xVNh/lSR7PFf0Eve/KO6uMRI
 UvQ0mHDFZjIVusvQz0mu4gwoiXyOro1sGfCPwX0GC4xYMnPZIazn3CWrzzwXNKjCJ+7gpd4f3x
 nlrkWwaEiu0Isrjke+1HbfJ2S5RZzDJpTs0vJhD2TeAHbT6NHIvSaa1r2qYDj1ebdFZOmLKAJ/
 RTU=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="130704517"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 20:02:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXR3w/xKbeu1xPkbhUCGYUcaEgfONNx5AZ5E/ACDYtKdZzkBj2vww6otBsj9ebbFSOgpSLhoUxcHKI5hh2avrXDr9HXljUI4Y9jucvHAxX362r9IOLQyWi+p33EMU4Kutp1BvOPVkAbGiZLMfMEt1LhiBgwadP7HJAXFKv7FNODNJgTCjwhfl8ccp8Q+Bcq0cArOrh3zxF0rF3FcGc4VLye/gAi8hke2BnYRAp+eEWoys7JfecrJ591rjHIXRfiMmew0KAMEzY0PtJnPYEHXkrvicCUYTGBx6+NYaouj01y8DY04QkxdKAZyttjn6f3x633OPojWMHJt9ukaUvRLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXJsvpvx0QjYKYZ9ZcYt531h0mH8CsQHAWTtinP1K4Y=;
 b=XURTD92b3AQdiQK6UVS3tS/01zp6Jow1T8lP5ytOMIiSk9pRAKKilzt1VqzlM/jjydqqu5otm34JYMIB2fN/EsbaaUQanh/XBMAiu4eRpfNfM9P/n1nf1rmLRGTFHLTmye0DyXwSQuyUY3ZgC6Tu99Tf9P/SPI8PHHDcqYkWuWfjR5DXEsGQOKobTnR8ThdxTS3z++dWaAzACu/qP9wRXI1ZIoq7uIKN+HMLwX9oqA2KmHI6C0TRU2IPozLasxddxlldQcNK6Mw3T8MmMTRLaCFdcYDHMwXh7HYxXB2jvQC1bmtxni58RHIuvdDfV55eX/A829eq/JO4FE0KZmKOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXJsvpvx0QjYKYZ9ZcYt531h0mH8CsQHAWTtinP1K4Y=;
 b=xM+Q17sV49+fimmsmqFU/tR3LTZ1o0M3265wkQGHyqG1KFprVU721HHPoa9XWZr7CqHXjbxB6GQx6O850ecACajFYLK4rwKitJx9SQ5jpWq60shHPZcKoqyA5WCMoAcd+HkRRMqdUGDORQS8hwinOIr358wghQV/BNF+Nos2Tsw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3597.namprd04.prod.outlook.com (10.167.129.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 12:02:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 12:02:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/20] btrfs: refactor find_free_dev_extent_start()
Thread-Topic: [PATCH 03/20] btrfs: refactor find_free_dev_extent_start()
Thread-Index: AQHV3NpnxoI65m2oUE6CjyZRMCbRDQ==
Date:   Thu, 6 Feb 2020 12:02:12 +0000
Message-ID: <SN4PR0401MB3598B575B00C5519FD9937419B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-4-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e256279-aafa-4e19-05b1-08d7aafc66c8
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35972AE6FBB07F1392AC49919B1D0@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(52536014)(5660300002)(33656002)(8676002)(9686003)(86362001)(2906002)(71200400001)(81166006)(81156014)(8936002)(6506007)(53546011)(7696005)(55016002)(26005)(186003)(66446008)(66946007)(91956017)(66476007)(64756008)(66556008)(4326008)(478600001)(316002)(110136005)(4744005)(54906003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3597;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfQ3HY94ZBqb16RHehj0Ijjhyskkc+23zY12tRCKSvspCB/u/ex6anV/8tZeQ0VkJNEFjjShESXGhwz36BW9JbIqrvOnQAoCY658S57r0+y/9OjsMcwHEoaU+ve95fw1rCekKKZfFgHrsBhVx6hTn5em5zngO+yp2yH5MYtwhuT8qd1IPxWv9vLExvKFeymAYM/ZGYO3CIhlOUKhtoC18gvgRZr9UrstviCazUhhAE3Ojo23X8jTWhg979tad/SK777M6JPDdpriM5v4J4jezfzpl3uibyh0xqNWYv2EIGxi8SRhC8n5EjTOR0pomQN7JuJCWwOawlqAW0nJnfPPytO8rm2eiTbLITJYtIl/xGvtOFwdL/tHoaGa6mIOo46gI+lTErlGQIrnJ81lvx2zI+yfm6xNwraO2bJejT/uctsO7T12KUXmMgr+KYllN5EO
x-ms-exchange-antispam-messagedata: +voVUohRaHO7QI60gQm0j0CzXnj0jdur8OIdYp8YtcsOg2Taru3jHC2A8Zb0ami1QRMr8P858XQ3xPbfYybPxISJa7VL5uMmxifwqjoXXcgd8ZyqR4oPnv1rPmO+HubOfA/BA7dt+AZk+Q7rnKxHVQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e256279-aafa-4e19-05b1-08d7aafc66c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 12:02:12.8090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+rDgByh/lMYSgdVL8LV4i0JK2UXMOSTF9hDMTPI2vEdhNVqK7kxuuv3pGVYrmEF3bAVR2fQhV1x2BunZOKePkWKLpZC3liYzx5ovAj2J2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/02/2020 11:44, Naohiro Aota wrote:=0A=
> +/*=0A=
=0A=
Nit: /**=0A=
=0A=
> + * dev_extent_hole_check - check if specified hole is suitable for alloc=
ation=0A=
> + * @device:	the device which we have the hole=0A=
> + * @hole_start: starting position of the hole=0A=
> + * @hole_size:	the size of the hole=0A=
> + * @num_bytes:	the size of the free space that we need=0A=
> + *=0A=
> + * This function may modify @hole_start and @hole_end to reflect the=0A=
> + * suitable position for allocation. Returns 1 if hole position is=0A=
> + * updated, 0 otherwise.=0A=
> + */=0A=
> +static int dev_extent_hole_check(struct btrfs_device *device, u64 *hole_=
start,=0A=
> +				 u64 *hole_size, u64 num_bytes)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +	u64 hole_end =3D *hole_start + *hole_size;=0A=
> +=0A=
=0A=
Couldn't this be bool?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
