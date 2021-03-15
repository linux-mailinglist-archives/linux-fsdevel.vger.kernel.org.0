Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6279C33AC22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 08:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCOHWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 03:22:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47042 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhCOHVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615792912; x=1647328912;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=I/V81fpqYgU2JMdu0B6O1d6RMHwDXLQ9ihQTpJiHgzY=;
  b=k2r0CfJ8I0M3O7MuL/XTONSmL09pgUfrU01YUkZVIBsnImJW1jG9E7p/
   KlbW31jdRAP85OcOGILQcFMKynhxg1rNUCerFAn7Z8XEsoSch1Fbir/ah
   3LbPLg6Qer3J2QrFEnTrn+WasNSZNOQWlDo/1UNpicHhAKLZ1dxJwib+V
   Omr982PALGvIdKwDfcjsV0Ph7WIdjuDx2tO5fbbgBkQAcdCmN/a3TL4Th
   KVUQ5TUu1y9K0IDseByMoY+2hkZHckOKpyZXB7gXX9/4UUmeD9ywlDYoO
   h2FjEVs9/9lZv5XsEk1NWon24f6+fA7D0BA+Y10R+VSHfa/BdmDudrmMW
   w==;
IronPort-SDR: 0kAOJ3GTDi+ISJ9a/0Yo6TglBeaidT2fMRz0F8G2rwsqHsry5oZLgwsdXzstfZ/yXtZV0nMWSn
 Wc2ODfP3B0vZdMyPFLovhiXugb9kdF/5pPgMiQ4vUv8+Be6TBg94jM0+HxR8SJYcNY5BggAXnh
 oOfCHQ7Dm47hA4rb6FBw+xh7c1cxLK9Rbe0GM7I92zojG6ITKQUtIvuXN99qLh8OdP117OH9PL
 5QwlV3g8N1N/xN/RwKDX34XSvVlQh/dM93AbvHlVp5ENhrsSlLOLkMXkzjjl73qF4ZwzDlx/AI
 BSw=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="266522692"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 15:21:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFClbg6wlyPb/TuB9lTCiBimj194rbW0Rk5lRDA0bk7ognX+Ee1pYphy18mwE+pGyQGSg8EFShfncvB/VmYiwZ/SzPmFac/5dIshvpVsFfQ0Ic6y1a4MnMZrI7KEQMR/EZAcSf4PjHNPVIBV5P5KBou0PYclo8Z2IkzNBt4eBZABOfGmEcY7DLzVzmUAFAzwJOXtKCtNTm7BJ2QPCENOW0nABby4eS4jIoPRGNtp6skZDZRpa6mXZ1n1UkakZAhoGaUmtFNuDwgMfsUYuUZHLqMWV3jrdlbMN/hzXRKntanh+Jj1yKB2FlcuxEhN6gt+6/bepm+kxuekoBm/QvfVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkgYLfuGoWmIjoVNWVbJadbNhPrWiSsF9feD7G8Z32U=;
 b=Xt8KFLUWdO2UKaKrMEVTq9HGCbC3Kkymji3AmO1oYX42aNCGMd+fGBH4sqHQi5dEbgatbop3Ic6xA+wA+uAHagE/A57EowfIyja1MKys/HnXe7kyL5lGk+8igewNwCc0txmxZj+imlxBRjqFzAh9HRpl1JmXpNtz5CLhFxYqqD9bgf9r8L/osZcDU1KSc8sQ5PGxHeDnnONMBpguaDLW+jKaBuP29sePxkpWERRmjAZoMtMZ89MF1EBCQ5R3Ap2neGKf+LLJn6XWac/ViBL1JFzxRZoIaXPWqc0D00vVzOE/GGoNnVP7xPCYGd7LuSJoXn/+9P1/88FhleVImmNKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkgYLfuGoWmIjoVNWVbJadbNhPrWiSsF9feD7G8Z32U=;
 b=rCe+NW+6Bvuw8tbemzp3RlS5Se+4P78Ui1ynFqfCOIBgOz9u9DcqX7BPByACJYgc5yY8h55ksbvaLCy/TWvDCmK62kjn2T9ha9jnlVvhBpK20mux56IKphvxWRsx88Zmjy9p/qUv/l0XpQyjNHghXvdwITpvGnhzA0I3Cv40VUQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7368.namprd04.prod.outlook.com (2603:10b6:510:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 07:21:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 07:21:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     kernel test robot <lkp@intel.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Thread-Topic: [PATCH 2/2] zonefs: Fix O_APPEND async write handling
Thread-Index: AQHXGU4zKEkqYN3HmkWOOzLkQ0PL4Q==
Date:   Mon, 15 Mar 2021 07:21:39 +0000
Message-ID: <PH0PR04MB741614B0DED04C088E0B075E9B6C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210315034919.87980-3-damien.lemoal@wdc.com>
 <202103151548.W9MG3wiF-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:6d29:9a36:82c2:4644]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e3ddcda-c03d-4a25-4897-08d8e782f9b2
x-ms-traffictypediagnostic: PH0PR04MB7368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73680C0589EB632C7B5679069B6C9@PH0PR04MB7368.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: erxwBdf4OhPR0h0h3xtFIxcYHW8xsngsI7Fq2QKfYuu8ohMFVps/5aO8Mchi9hZQufqHJhHq8+Np9nawLxj1hxNcUMK5NSYctkARS0LR3tGaBK48Jp82yTOHXMuFo7xJ+2kESb/pvRDnqkAURvdwXZPbX8J0BI/3qv1n+jffaT9VGI9ZrOdXt5HDNPJNW4CAwVFscoTPVBOgROI29JGf5urU/O4GiKG8aGi5fsgedTCuJfZMAlhW9VKoc18mXwOVUP/LExatHy4SimWCnfnwxf/7txi1mN3pHgbtxCdVW90UO6D8KJ6YgJCwbZc/w2e3dkju3ycAORWunyo78W8DFJA+6jL8vUpWf5lMChF0trZlxQ4AF1cQb1xQOjvecWX+pJlVgTFJpwwaxhkQTc8sUIfDnfUVk7Zo6YYnMU0oTroAYanSyCirfTo4WP6QE3aIKUp3FUTkRC57gG2Pn2kn0vKlZQi67QN5QztNPgl/P8h0pokfrTuSYhjXipbL/S3vPOL1EOqJW/jRSPBHaseMgN8EMcF6iSmeTioF8ga3NnFeLclQ2GWdJ33QufZbz2Uc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(8936002)(7696005)(4744005)(55016002)(6506007)(83380400001)(66946007)(66476007)(53546011)(66446008)(8676002)(9686003)(71200400001)(5660300002)(4326008)(33656002)(76116006)(86362001)(52536014)(186003)(478600001)(316002)(66556008)(64756008)(2906002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r+n9zuFMEuhxVHP7gv0FR+4NzKjzqRuvUcU8Ui1n4bQyqLmOMBXwaL6XBL/T?=
 =?us-ascii?Q?jep+75gTjxuqkx79HfPCWHBtEqhX5FNrIMZbTYC0rsAY7YF69dZa7LiAIZvn?=
 =?us-ascii?Q?BUGy7OukH0eTXhVpPe7ZEzhjqoGbpkAuhr8MDKiTBan553HEYNYcgrpKrRUL?=
 =?us-ascii?Q?NrtDyAhdDc5SaUDRumtuZcHVzmcPL9MYV9IZEo46bJiEsryCtCbZpHi7cn6T?=
 =?us-ascii?Q?TB1GEvvPV3On0q6m3hYIevzNhq9HPsbPDcwH9XwxaL+W2TE6Y5kHElIW+tmu?=
 =?us-ascii?Q?i8oS8rUQfbce9oxca2rGxlBozQC2PEEiVdp+72eXDus8yEe5vxtXECaEWv/e?=
 =?us-ascii?Q?RPj5pngr10g5nkTcnjzauCM/3ATOAUd3q5JUdh9+GmdL7PoQ5UMV7C4leMUb?=
 =?us-ascii?Q?Yah4L/yjv3i+rWayLp+PTWGjD+hDKtv3IHJmZwPOHndj0465WpsI+ExVnw+U?=
 =?us-ascii?Q?VgmyvWKsmh1ZSjx0gh0zIugChyCthKoabuVV2rEumVqIpBBdghuj1uFSuv5H?=
 =?us-ascii?Q?6v8SR3EnK/lxK0rOMamDIz/2nAHEoyGx0yYN2WQsZgg7NQuWO2IZtiHZ9EeL?=
 =?us-ascii?Q?C8BBy9MiaL5JnhSFstSMt+AsANvPcDpadxRE1hQE5Q8uUEghIQX+UfJdwuno?=
 =?us-ascii?Q?fEQADjUrAxc9e2kaq3lXmlIJLk9AXtFM0FG5pXq9cBEQCc/LWQmTQaTwqgwT?=
 =?us-ascii?Q?S9ZVzJG+qVhAFgpWw8CLGxEXBLjjwPIVUybecQGeA9uG6eM1sxJcc6uEXjdf?=
 =?us-ascii?Q?v62uX3zdfBQYGFdyYuB9gdyU6mx4NeaZD/Xmf+O9CKeWHEqX38R0FN2/XtaE?=
 =?us-ascii?Q?lvcWAhCDQs1kIRJ9rAbj+gmTfBS2hAhVLSorPijT+nJdQPI4X98l6voAaNCr?=
 =?us-ascii?Q?/VWU47R9WVFKwg5OE2NOiD1kmTMUegsNHblwmOQu6LpYepInjzgucrIvTy7U?=
 =?us-ascii?Q?6PlH3B44+RQtrsZUGc+Ig/ejaUXcITD94sUX6bjar6lcKR8hGd7ERcdlb2Nk?=
 =?us-ascii?Q?OhPjYgORohpsAyNxbXWQCy1BrsJ+2VP4PJoC1uvLxZx/V8zFhD/y+tkpeKAz?=
 =?us-ascii?Q?KugEHN33muAVUrG2KpgU2bJBp7mSGvhITYkq1E066DsBOEKBIqXLkn/Iu/wm?=
 =?us-ascii?Q?wWUaYdEWpIq+3E+J4Z6MWI7rRExU5hk/SFDuV+fEYt5+EBShYsm6vNztjjVk?=
 =?us-ascii?Q?436ImNLU9NznCDvqy39C8mF6/q8Qan31t9JovqaEPrD0zdYhGUsKAI4twlk1?=
 =?us-ascii?Q?rHi6Xl44HhWAr+41PUkCI/YxifwI1/+AAbfEBq3yxfZv+Xccn9kzmhul96W9?=
 =?us-ascii?Q?n10hG4AC3h4F2+Byph394cDOyZ1LgGlbrLHUaZBXrQDoXEF/PDj4CtVbM/Jk?=
 =?us-ascii?Q?/1oZEYm/fEvJX86vkxH+YAgeOR5LN40yFvxr8sF91VSsNeK1fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3ddcda-c03d-4a25-4897-08d8e782f9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 07:21:39.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHdQ4v7aMAsecOEKJvy5Zf6tJCe7UpPAqVI5+jbd9Z1OVA3yOZWiUWEmIfyGp2c2PhtRr0fjneJ/sdWh+IXuvLvOfJVFeninXxNW6UcomWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7368
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/03/2021 08:16, kernel test robot wrote:=0A=
> 818	static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_i=
ter *from)=0A=
>    819	{=0A=
>    820		struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>    821		struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>    822		struct super_block *sb =3D inode->i_sb;=0A=
>    823		bool sync =3D is_sync_kiocb(iocb);=0A=
>    824		bool append =3D false;=0A=
>    825		ssize_t ret, count;=0A=
=0A=
>    843		count =3D zonefs_write_checks(iocb, from);=0A=
>  > 844		if (count <=3D 0)=0A=
>    845			goto inode_unlock;=0A=
=0A=
Args that needs to be:=0A=
			if (count <=3D 0) {=0A=
				ret =3D count;=0A=
				goto inode_unlock;=0A=
			}=0A=
=0A=
Sorry for not spotting it.=0A=
=0A=
>    878	inode_unlock:=0A=
>    879		inode_unlock(inode);=0A=
>    880	=0A=
>    881		return ret;=0A=
>    882	}=0A=
>    883	=0A=
