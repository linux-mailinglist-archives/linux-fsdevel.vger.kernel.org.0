Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF00C2F47AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 10:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbhAMJgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 04:36:08 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15056 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbhAMJgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610530566; x=1642066566;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yFKLaYamePzWW3Egk3bMBt96kkcPIF3Vovro0H571t0=;
  b=BUzCFjj6vTcNVCzMiQWUJuQUIzg7NlBbyP1+FGDIiiiF6a5vQGctiliR
   W9yvpxgGzDQdDPqwZaZ7x7FPS0O56srLNnHcFijFIUq1Q0PE3jp7jXGuz
   UCWgAwoYBCce/xxTLRCTG/uOtNxj+xHmoSqHaYb/lU0S3PdhNmpqvy5q2
   F/FwMU0zqZHsJ/dzJFGWM5bAugZjLHW8S0G80/w/uy+n6UEwgjbLwfxkF
   qXLhK/bJvzVdlI8mLciAmhF9utPRQWRX9/9qp69+SP3LQWPXOXJkR7xfo
   JzmVU7TfuB2HdOB4yRDUErH42rCrZc9bCrJwwXX2e1lygYWQQgDPbZoH6
   Q==;
IronPort-SDR: e3U5cphri20GvGqwJkM0A1fO8htY7CGcMAsWvPXpdPyZSUPBk5UkIHAbm9HoKlTwR2KbbbVmve
 xN4NbqmaUxpFga6Dq0m+2gIWoomR2k0eBe+xIRuT8V/spxr20Y7nTnDDvX3eAhhjxI0E58K99X
 RM+uu5lo81YOvdKjrpFwFff0twVGc4i4ml+1vDaVNWRGO6Ncysrs0vo944n4Na4RlXnps9azQn
 LyybTUyCmZXb0bFl5J6a8E3EjFi937HOQrCkJZHMHTh+qp832skNaJUCIxhEBrTOlr5UlJmk3n
 wvY=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; 
   d="scan'208";a="267627233"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 17:35:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAqQHDNYOXtjYDpEcFcEryMuoI2j7Hk+ioBudQYSL80TnCWlsj1ghUko2LmAhykq8N/4jF/BmDl3ttK9knpo3MDe1Yq4LphPCJLg4472dyGZNqlgEjyl3LhxryhI9/SN4ZQOkrsOPeMbF9LDXYO/omoMt+rXIeztio/8SI9tfrJuaPxwjK5gvFaq/VRNxfoKSgPwfr8nW042Nw5eGT3GBHI/gio1xqA91qS7SVt+MBvkPySLcDnj2cr2eSDhh0wQ0VTHzM3BphDyKjw2SKCy7tX41GHm2nvQi8LSiJuZL/v6mv3Tr6ngoqEi2R48JaLiB8ildEIy9nP9k5k21zz5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFKLaYamePzWW3Egk3bMBt96kkcPIF3Vovro0H571t0=;
 b=myKKwIyULUrjxxpoSw4w3arUieH/puKQXA7VByZnBml6qhwrRFkQKtr+kMm5AzEZI+iuhJduKqo2ssve5caN/Sq0tqddv+VqX+eJ8CTVrjPEREvRZ1M68l6rJKvv0yUinRBJtpj+QRW2z4KfG5G8fnTEb1Ux3yq+MBMRxdshbVa8xKDCSc4RohN9iEtvTnyhtfftekmnYu7jVGJPcrBljCDDXtaOIyd7k5rBd9uDKowvQDN7VchvIc1CuqONQqEo8w0RlKd7zD9/hpFhP9kJxsn473JCD6W/yLc7OrBBxjuL49m6EBtO24IUU1F1xDdT+4O82uqAOBb50bVXHUS1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFKLaYamePzWW3Egk3bMBt96kkcPIF3Vovro0H571t0=;
 b=zivR6JZu9Bbaq/xBoS8dfCmFX28CYOzJ3jkD73KSAEe2DQlUws80RqngUAH57rfYrGJNRD6M9OeSo4xbNB8oCF3Wp6jjLdvpGN2in0etD2uywJF3MUGa/zZmGlOMxRoHIUYKHkWESEVvSmFcaeIlF44pUMfrmBDuo1kaigfgGqc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7579.namprd04.prod.outlook.com
 (2603:10b6:806:135::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 09:34:59 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 09:34:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 02/40] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v11 02/40] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHW2BYftDRqPOhpp0WPlnqf1G8OJw==
Date:   Wed, 13 Jan 2021 09:34:59 +0000
Message-ID: <SN4PR0401MB3598E40721F200162D322BBF9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <33bbb544385b7710f29c03b06699755def39319a.1608608848.git.naohiro.aota@wdc.com>
 <20210104223056.GL38809@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:38c1:d5fb:3079:ba93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6595876a-2544-4f56-0916-08d8b7a67ebe
x-ms-traffictypediagnostic: SA2PR04MB7579:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB7579B3DDCD6C14618B1738239BA90@SA2PR04MB7579.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEPseVYC6ICLISv3xG6J5O7Nf5dGyjCpeQmIK89FFZeNTGy8nXhW/A3Psa3LruKNc+TmNepTTx+27QXBwsvB5NOLBp81nS3lkBqQ+XTb1RNqwMUyBIbK8TOgWlnbwvCwdFPMynbFhYvFbhTJKDaeUcJUz+btuqTE/vkVfyfcD/TFteDNES+YKsxiB/7GOVRxFN0KXn0o4E6nwzU5VUkfcryJvotyBHtBmD+krwr5k2fboLh16Pq7nM2rCnIuvfIufdRywBxjghvB+1EL3rEagHxX1JeBlAPdWhoN/QkfTanscjBg5UY71UXDePDsYaf3F7QdNP8/XY9yHltr4UOnsm9CgTwvUmwjz2wsp0OJTOOG3ZAxBem2rZmevm1yyhZSiznGehU1I66rCTQLdNJE2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(86362001)(52536014)(7696005)(5660300002)(54906003)(55016002)(316002)(33656002)(110136005)(83380400001)(53546011)(6506007)(186003)(76116006)(64756008)(66446008)(71200400001)(2906002)(66556008)(66946007)(66476007)(91956017)(6636002)(8936002)(4326008)(8676002)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zLX5q87lGVlTPW6VhqDRX4INqGv11meAtPdD4+POq9SjqVK1aYeOqYOrzTjR?=
 =?us-ascii?Q?mpfRVLI3jG5hYY/w4ZmKfIpAEzVEr31cWU57DSEY1vdQybBTmMQVrDU1wKFu?=
 =?us-ascii?Q?CVyTTX4krqBRbWF9zBmSq4cANCerrzGLgwARdTzWpz9ndrKeDOc3JgTliim3?=
 =?us-ascii?Q?kAfSGkxw2QT1WYWDASoZFRQ0mSyJpNBaCtSWSVGZNcSpPLewaz0xxcuXUpHl?=
 =?us-ascii?Q?mfMBLxDSBVWN4SDeEx62L0W9skRAuXSfm/lewAiteEDTmPIQYtjyqyblgM7P?=
 =?us-ascii?Q?irlNQZNmd1s8sPBDjaoleGFG36jj1j7q70AHO41azMyGuGnPdgihb9tFIw7X?=
 =?us-ascii?Q?t/ieDoolECxBD5SQU694dfzF2imjexRT6XWjC4UBmJl3rRz3mPgjX44dvHxX?=
 =?us-ascii?Q?qoXb0MqR1VA3Kpl0lZI+GHbn+37+3wPXq+KIMNVH8AV3Ktp7xUpkH9DOkS6+?=
 =?us-ascii?Q?3DcSLljGHBdAhH/K0oP6dtNvsP62KxP67dQH9AzmKZClG4ARMbTgOin6NCE7?=
 =?us-ascii?Q?4LriIqqChLNuQy2pW5EqYMc8c0j4qS9vax+SwnCUWxhXKAHcj858448N/n8V?=
 =?us-ascii?Q?D9IMxvWim42setcjn7tJgAv3/7JEEhhSdFNet8KngRMOoy5TwaYTMwV9Wfs/?=
 =?us-ascii?Q?cWGtT8jel1FbGSlseiP3GlVd1m1jn2jXEXSNELL95PwxNocbYtfzrYdGfPUy?=
 =?us-ascii?Q?Njk928SAMtVrIpn9KZEdg3vnn+LomsDrVwinlBO/0NXxO3wwu1ODtQOUexj3?=
 =?us-ascii?Q?0UxQI+I2RpjIR1kTHkFR2MmRxdm4nwong0L2bnM+VZALgnOSD5B0liGfsO5K?=
 =?us-ascii?Q?HNnBO8bz+RWVKaP6K+Ev5vifnrpo2c7YIGyGGqag5QCKdTZYmxJFV3NIMykq?=
 =?us-ascii?Q?kANoEx9RSlax0qylJfEDJrt9UFwYw6YHS+prQ1fsM2OaJFhBSAgi+O5qQOGv?=
 =?us-ascii?Q?9y+POZKg9wWX8fttb4uds79dIrnnlNq5nJ8x4kQpp13RsZzIcbwFBwaB1Qm3?=
 =?us-ascii?Q?o1uoc12l9LrnCRIrRhKiq4Hi9MlzvR/YF5mhr9OiMos6O7v3mTcTcRna5mIO?=
 =?us-ascii?Q?MlEgvKDS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6595876a-2544-4f56-0916-08d8b7a67ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 09:34:59.0923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syTpj9FGN9cS6YrixRGqXSj0qqNiZcjm+F3vhC44G+lK8TqyMEqwthgsW1sfV0zdcYkZjGxaz095vIr4C9uEu8QMw452zi0UVg3WKUlreMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7579
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/01/2021 23:36, Darrick J. Wong wrote:=0A=
> On Tue, Dec 22, 2020 at 12:48:55PM +0900, Naohiro Aota wrote:=0A=
>> A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding=
=0A=
>> max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds=
=0A=
>> such restricted bio using __bio_iov_append_get_pages if bio_op(bio) =3D=
=3D=0A=
>> REQ_OP_ZONE_APPEND.=0A=
>>=0A=
>> To utilize it, we need to set the bio_op before calling=0A=
>> bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so=
=0A=
>> that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEN=
D=0A=
>> and restricted bio.=0A=
>>=0A=
>> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> =0A=
> Looks fine to me too,=0A=
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>=0A=
> =0A=
> Do the authors intend this one patch to go into 5.12 via the iomap tree?=
=0A=
> =0A=
=0A=
If we can't get the whole series into 5.12, this would be very nice. If Dav=
id=0A=
pulls the series I think it's more of a hassle for him, as the btrfs tree w=
ill=0A=
have a dependency on the iomap tree. But I think this is something you and =
David=0A=
have to decide.=0A=
