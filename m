Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BFC336B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 06:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhCKFBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 00:01:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61569 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhCKFBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615438888; x=1646974888;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jZRIjwAoKyVaQXGobpMAuuxe2bfZvr/nDiLtBMIbfE4=;
  b=bqldS+ZNDk2EbPUJi7fss3/9uyIyTXx9pT/+IAOKDWtMfNftVZjvXdoJ
   FDjVrAYGrHHHmb9gz7GsM7LdHgiajQWbat51TUB+cJrki6YmR/5YR6YmY
   t2wKp/XIMAFroUWCoHlL1vmgAzL3zEeIv+EKqZDyviogsnikdcOObgSVJ
   x3N/nqE7kaEPm4PAkuNH7tNnW2BiIX+15RcF4CKlb0vy//4dxI/f/1D7c
   GlQYd5l2YfChyM4bv73Pqw7J0lgJEtHEQ2huCBIp5fe7e102Y1XYMZC+6
   buMOa20thS6dGMwGVTGPYxmlnZBBEbTqHAM8e9o1bDlkAweWjGtIxaEG8
   g==;
IronPort-SDR: FSaN5MZW5nzVaeDfygtHP3eQoqjCLNfAkqd2LikuiLaojz5ZyUvdu5/TtExJeySHxV0HhhslR+
 7QcDogkrCQuToDJFjU6Tiqm0AQ7Jn/HjrPC6BISffN/nvh/nZu5IYgM7ImwBBqETVu+wAbt06k
 UC1pbvQ3X5tPO0a+nf1qhXekr4ns/6UiH7nFTNDj6bYzK2Cm7KohdS9v7U5ZrGtApAgvKiMsDC
 gj6KS20P878RVyRZk3BScgwjsNQYVeuUhjLQ7dy68RJbIM/yKCEFloU5G+Lc0o1VTQBAJTEcyR
 4q0=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; 
   d="scan'208";a="266230138"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 13:01:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtV3QTbB5gKj5nnXFznPKxc5f/qv2honEZTZWw7Yx6R12eL6P0ci8yp0jT+xPLpZ3pDhCcNSxEQ0E7mOTYgSYZieFE65vHsa1kN97aEBj3NesF0fPecb98GdLZJr6Mmv4OcG+824JkAA71+6L3+1FfVvdwcyRrUTGfcl2Ee2x+Yep8R9KsI7dn3VLEIbKOweNeq8qKUCUGU1VKaE1DCaDXzy3p914T3f4y1h4SM/0HiUzvD5OGqns9nIwN75SaY2FfKCHde9oLczaliVNqlm2mQg03Z6wejecdhjWV+VcFqhUJzJxmzzYXG01pLoUsRIzoG2vL/WPgzIw4UR3t1MqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDKOKrbrdq0xspjj6la/Qz4neMku2mlD2sMlWiW4MWQ=;
 b=IP8JgMD9eVbpeeTXPEH58QccRK0AM/CafVl9J+egFLKPrwSMG7DJTvxqbOma17sUZ3HZcZI9UdTUBDgjTWmKMeeK5zWlgQHkFEjabL+1AbYVGcuHHgI/YAG43CRt2qNSMaLd5sjOEbFXY6isnfTRfZoOgymGkfGvhgi/bjXtCsuRpMRZgXOpt8RHkt2hBmHdAqEtOcOF/s6YRYvPRI8iCPPnVDyIfjU024H59Vq6VmToPGT9TkYyUi2MtvdQK01VqAzGLeFPnKusxUJ96g+7oczvtaKxIsSkxlSQsKVfl59JQXmWJQ7ptbhnrEqN3vwxC+IVSOheJwXQoiaj7e1CIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDKOKrbrdq0xspjj6la/Qz4neMku2mlD2sMlWiW4MWQ=;
 b=Im0XDTF+eERles4TiLUhwyHTNvTjVvPK/aavJPxVmiTotPx9plvz+ruS23OmAR6SoHA2ni3Jb1eLqrzsfVxiOoqgp2gOeIEmphBwnnc5hsAdrH2yi1vCvtmz92Tx+MSEfQLHwEu5OPJyKkfpE3gg03k8GpGrWEy1cO10F6mnc3k=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6976.namprd04.prod.outlook.com (2603:10b6:208:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 05:01:16 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.026; Thu, 11 Mar 2021
 05:01:16 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: Fix O_APPEND async write handling
Thread-Topic: [PATCH] zonefs: Fix O_APPEND async write handling
Thread-Index: AQHXFiXgoirGtY7WzEOZyfO7/xDSiA==
Date:   Thu, 11 Mar 2021 05:01:16 +0000
Message-ID: <BL0PR04MB651484CFF88B469A23C95DFBE7909@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311032230.159925-1-damien.lemoal@wdc.com>
 <20210311033624.GE7267@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c1a6:aaec:6201:ec23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45b8dbf4-2861-4431-390a-08d8e44ab36c
x-ms-traffictypediagnostic: MN2PR04MB6976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6976CA69E9A71A89F2B23CAFE7909@MN2PR04MB6976.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBGo/s1+fBhOawh5OCiXtPk5ikJ8vDtl/RVNLrHY09uB8TetLHga8vITH0+y82k3O11+7wBnXoby8CkcZBffmAFDZnFO3fOs7dqso50WE4DYyzc8SC+HR7aD1Yw46gHq++nEPza5tKrwl89HsZU85e+2hE60CMYeAHB5WnlX+1rxjsEgC5kc001L+iWhDTPAViK8aC0745Fqx8enud6bVQUUpNxGrXR6apeNbiSAv4RayZLJzUJ3OSK2uA34q9MutV7oilbgGkohBHgkytcTC7WkysD9T/fZWPg9Nq01KBl0v4njVRNrC8PHjspbHflgMypVt4dybewDZTo79Ndk1T1nu0r+CADrzCk5Dt4D1oEDDT0BHzKnufPzjGD9/peDl8H9PWLkdgA3Py2MwQEVTuA2KKReD6y/kwTfTS3qXrJaj0wj1TWLJWFQUTTzVLLrrvLZ39bNbc3QFyj2d04msxO3e2rAcXaCNblpVmXRya2fuZRjKDF6yiuLi59m8sVszB8OlmpKqe+jWPel7DQWqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(54906003)(6506007)(478600001)(9686003)(66446008)(186003)(4326008)(52536014)(2906002)(55016002)(6916009)(7696005)(53546011)(86362001)(5660300002)(66476007)(91956017)(316002)(64756008)(76116006)(8936002)(66946007)(66556008)(83380400001)(71200400001)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KnZja5qxKbHhzFqu3pEAZ/yrdGFpPQrnYJH+a7pN+vXqCSGWITFbdG2e1yGu?=
 =?us-ascii?Q?G9Hg5//7DEVMDDwEnkzA18d+0/CQtLypOFXIpwY2gqKFgErp4jnZjEXj4wke?=
 =?us-ascii?Q?sllxPvWGwnGrZ9UPTjUCoLIayPTgz87ngd8Np+UrELjfgc+/xiwf7F/0RT0s?=
 =?us-ascii?Q?pkVw86QLg/AHzM/2D5INeMU0hOxwOi5LntpA9cU1D8a1bn7LlDJ0h4r0cTAu?=
 =?us-ascii?Q?ub9+XxwuZTP07FGd5Hif7o4RibmW9xMvuZomdNmZtR8iV3FPZHgGSfAo9wa7?=
 =?us-ascii?Q?je0xqwht1D6AbIvEByMk/iqZcMHK9B9xC9x5OlDN537t7yxuoWJauhu6Xg1l?=
 =?us-ascii?Q?WVPeJoPtipmAgWkMpeooEt7FAtyz8hI7TOX8qh87nFWM2mzg2NpKxn1tOvr4?=
 =?us-ascii?Q?c11yL2DTacMIU4vDwN0VJZvH4LXbwu0iPictuKOfLFbO8JO/VtvD7SsPLWPV?=
 =?us-ascii?Q?k1PyFyMh1ZdLtW9EQ8mkFDxb5bZK7OasxQfOyH2Ofkc2N2p7j6FfJF+qaWLn?=
 =?us-ascii?Q?z0kEM8En2iC1L3lks/Y8kq+fjfDP2BTLBlt6AqaK+96sApSySE0LgzY2678o?=
 =?us-ascii?Q?n/ZGTXC4IeZh+C4l6T63U0j8J4eDXyqiOT1LLp2AFHt4F+qBAQlRkHCI+cIH?=
 =?us-ascii?Q?hU/8GHawEVmw4eoobF5necHesuSY24aQv9vuCWjkBZnf38Y7wRBXYXFH37/b?=
 =?us-ascii?Q?NEQ/RPntYEtcnBbwbAl/hqgHwZ8tbPgZ6/dkl4cs82d/1zFe7RdnWq+Z8CP/?=
 =?us-ascii?Q?4Jfua4/WMRQE1vqxz1adh3OIrQxvIRXViqYVX0aCx/dqPiddnw6hflw+hRrJ?=
 =?us-ascii?Q?8kLJKseKn2aBx+1xXewpTl9UNRi6hKAYFPx0IMEBWneW7KdaRNKmU//8kwdr?=
 =?us-ascii?Q?KYqSt9B3FFbhH5kc/SUvpVdvRk9MfBs07P/Tcbn9FGFN/8dCCkEeooaWzpmE?=
 =?us-ascii?Q?d/B3Gd5VKMoCfEfjFji+IEGv2F+yOdoI+/sbovKbtDmhu1ltrbEbgs7BzwzC?=
 =?us-ascii?Q?7wjmZ0yMLsRrtKluJm7Yap9h1R7ntVEgsEPBEjvQp9c8RxlhLsrgjst+bItP?=
 =?us-ascii?Q?p710tzsjCgrviQ+FXjgd+3h8BKCdPXBChcsAl5jXFFO/5avPVfif/EqFZHDJ?=
 =?us-ascii?Q?YlCdAPDugVgtPD7fFbM0+IRZnyATllIy6jSmVkaihrTe2HwsoZxruq2jrew1?=
 =?us-ascii?Q?eyQY214ZbrcWdrvbV/lQ6DDqljVyrUheIWvXmUFp7yIbQ32aN0a7FnWWS262?=
 =?us-ascii?Q?9fN11b3WjRkpRKLuBbzLZ88ho5UTZRcr77kLoZSuXfgEqsTOWEAOPG13YBUY?=
 =?us-ascii?Q?cSVjOlWEgWx/P1Sluu6Uj89U/WGXOoE47Bq5W4tiZSTI4lK/w78C5imdD0Ck?=
 =?us-ascii?Q?cwRe6G5EscdCTSR2B99vnp/xf6qf/LUcVbLXThMBK9rWlQKr0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b8dbf4-2861-4431-390a-08d8e44ab36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 05:01:16.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ud6WFGDnAMcFO7VB6FjAh8RudCsEaVh9Q5AyELwb0n3YTfKAZkN6wxByT146P2m1KspKi18XFUuAiK341EXrOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6976
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/03/11 12:36, Darrick J. Wong wrote:=0A=
> On Thu, Mar 11, 2021 at 12:22:30PM +0900, Damien Le Moal wrote:=0A=
>> zonefs updates the size of a sequential zone file inode only on=0A=
>> completion of direct writes. When executing asynchronous append writes=
=0A=
>> (with a file open with O_APPEND or using RWF_APPEND), the use of the=0A=
>> current inode size in generic_write_checks() to set an iocb offset thus=
=0A=
>> leads to unaligned write if an application issues an append write=0A=
>> operation with another write already being executed.=0A=
> =0A=
> Ah, I /had/ wondered if setting i_size to the zone size (instead of the=
=0A=
> write pointer) would have side effects...=0A=
=0A=
In retrospect, the problem is obvious :)=0A=
But a hole in the test suite let this one slip for some time. That is fixed=
 now.=0A=
=0A=
=0A=
[...]=0A=
>> +static ssize_t zonefs_write_checks(struct kiocb *iocb, struct iov_iter =
*from)=0A=
>> +{=0A=
>> +	struct file *file =3D iocb->ki_filp;=0A=
>> +	struct inode *inode =3D file_inode(file);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	loff_t count;=0A=
>> +=0A=
>> +	if (IS_SWAPFILE(inode))=0A=
>> +		return -ETXTBSY;=0A=
> =0A=
> ...but can zonefs really do swap files now?=0A=
=0A=
Conventional zone files could, I guess, but I have not tested that. Not ent=
irely=0A=
sure about this as I am not familiar with the swap code. I think it would b=
e=0A=
safer to disallow swapfile use with zonefs, similarly to what claim_swap() =
does=0A=
with zoned block devices. But I am not sure how to do that. Sequential zone=
=0A=
files definitely will not be able to handle swap.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
