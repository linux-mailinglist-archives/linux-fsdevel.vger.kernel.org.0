Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4B1A4337
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 09:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgDJHyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 03:54:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24463 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDJHyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586505272; x=1618041272;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wztbGthZ06j/V3GQlcAgTlfonkt2hiXiP5GpujzktWs=;
  b=HOOhMnhZnQmwVIIatLEGFGNRD+eGoLOtyAKynVZ432vGhbjnLY6riwG/
   CkBpgqNx8SYz+Bp+7MbHn1oY+Sp9Lk0SRFGV16wz+lKeI23QRxFPxJLef
   Xk/LhKS/xtCboVPc6Dcsar9ZlAsiAQiwKA7biEAHXVzTdDe1FhovN4DKf
   ZgKsYZJzkJIJ1pKtd3JSW0hm5QcmwPyIgMFnpDjZ1IzgTNGcZ/UvynxQn
   pcyTRvdWIZAycljEtiuUG0HL2IhBKbnL2zeatei7EFWtbAc/3yTHkMD5s
   mEC3pyHUxEIugw5u2ll5HW3RvPZNW+yX4/A9uCbV+wh+wDXhlEP8nXAsD
   A==;
IronPort-SDR: Qe1G3XqMhY+iwsG/bKhuOsON95cknqcIKcGaOxWFQQmrLAqXrvjAOzyDFHyzpVdzA4d4HySGsf
 HweFcO7evZ6E+eoiBcc+1MGCgCnY+BRMpVq04DboMzXGXsDFkLAE8pdfBFsrJcmrVVMfVCLYfd
 +rozOSiqVD/5PcW/LRahiz8u6oT2aR+UwjACncAOOoQ+nqPmk12mz4bsKSKanrCfVAWo/KM7Gh
 ZZCp/dDb2b7H9cV49AUeWdNkdGf7eE79aFQtNeH3CBQQR9zw1uGn0XVuYjYQSyRaHEgzmjwYBJ
 0EE=
X-IronPort-AV: E=Sophos;i="5.72,366,1580745600"; 
   d="scan'208";a="237399485"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 15:54:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2IK6wVC9WOqd7zGfvg/sZT3jAiDlXnWJsWjieJ67UIqNFaGvG8AHd2fqM8VTD3bm/L+DdvTMHxLmJieNtXAZE678S5Guxm2K93lBxcFtYVKpw4P8ZGlTk0PFR/JPecF47yZzwq1eUZhM0Uqw5ci5HRTT4nmQhQK7zDVJHcYr8jem0Cuc9LJS7go2KYKMBmSIj2aL0pRDmpRFyMe1LYzc5ASNOgmigLbYLzxbnvhvnxTLnwlLqAf9bIPmkGp+UM4Ugik/kJC45dVKSgzsZ/C2PVKjQ/3Z1Yth4Ci9P0ITnFFUsIRdVqg+RsnQpOIdyR248ufvl52CM1FvKtmn3jAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6U5EJ6ITwBXtxG7NJxZTkqI1n7tAiP+Op4nDqN8/ao=;
 b=QH1IGOvotAcBTsfI0ykqkeaaemDceg13mj/vAcsDG9XPGphuPfosR0dPR7XSRbcQLuSfwlkG92nYMQEOJGrOJYEJFcojTCm9uXIAkRiMPmPEQEV9nUGFT3GHw6NYAkxzONmEIZbicCvPUnofQuMYCmSvG+MZgm5Msk02MAJkUZx3+qQGRdjzrZzjCHdY5GhtiAe3TfohLaHm0aO71nTyGas4k+cmyxK6S0IGAytc4cX4EmOEyydTZfNW2L3zr6p52G8Vxr9p5MrdiizoqoEhiPVnBuqn1LDmS3ZWSjjm+FQm+vvjQWtDA3HYw1mLvYPCNvxeoOcDQEudMfXhpSS9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6U5EJ6ITwBXtxG7NJxZTkqI1n7tAiP+Op4nDqN8/ao=;
 b=PpPy/1JQ1PwWFRoQh/9Ir+VOXXavJo0asaN3OywJ2fYJIV55zwzLHwcaw8zS1ox11t5fxGNjEkcU0mShQwqcHmJ72BOjUPWK7HrF56Qggf1adB2Yuj8P40jKI+l6T9kj8vAgrUIL1eDL44CJYjS+4211Ua6re5oe95+49wJJOaU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Fri, 10 Apr
 2020 07:54:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Fri, 10 Apr 2020
 07:54:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWDo9/7/TsxA+1IEecB4cF8olDQw==
Date:   Fri, 10 Apr 2020 07:54:28 +0000
Message-ID: <SN4PR0401MB35983759D17D7D5507AFFFC69BDE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-8-johannes.thumshirn@wdc.com>
 <20200410061822.GB4791@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66106aba-3406-4890-4235-08d7dd24653d
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3520A007F1C0A4E3929CA9F79BDE0@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(8676002)(66476007)(66556008)(86362001)(53546011)(71200400001)(6506007)(64756008)(9686003)(55016002)(66446008)(6916009)(2906002)(8936002)(91956017)(7696005)(81156014)(5660300002)(33656002)(316002)(26005)(478600001)(66946007)(76116006)(186003)(54906003)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P42wUxo8DHUc6X+JXrZrlSZ9gmKuhhW/NeBWy/mo26gcahW2mZZLmcmEoui+aLq+YcdGuxYqN5HlbqhsCaebY4VPt7sJtsLRyEX9IX+kl7UmQtCJLGEZezZqN6lNJpA5V2q588H0KzyidWkYDfcPUXOGz7lK2Wfbvrhb5Pi+0k6SwcQ9WqLJHG24YqfRAICJREQurpQZAZSsBU6cK6JRDY2ZZZ8EUJ0F5KINYNuk+o+LGbtDUNQAEWKZI3w8wJrOXNyCbd15J802h86bkCwwFouZjhYLbZK5H068vPyOr1KtzJBeUwCu2qh0wbmVNrUf5WjC+3TRUZYRajqw+Ym7ssMjJBNNAsqJy6G/HJaC1BEHpnhmVPGDCIG4zTpstDayavq+TkjiimmfEZ4Se/ddhXnq+26USiw+H/IjJLYavjA6nkvpuYiDyNO3ZLmLQAtA
x-ms-exchange-antispam-messagedata: Cj9rF7LtiwbiPzxCYKmG19d6HeW41USA0ztb5BSTEqAV2pzSxBts3FMiod/t/OkdEPF1mt62qreIfm28iuurUMcKINgGSSw7pABiE4Qy8r9pz095nlKygIs9liQ/8rgkqqC131rSlv13L3Xy0KxqKA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66106aba-3406-4890-4235-08d7dd24653d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 07:54:28.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSGCmbKkwHH915jAImGU2yFpaIcggiWeYsnANHWONhHAX5wZIlXTxPgMMeFIlQElTu1duovYBwYto2O86kN0tsA8m/iofzk5db/Ba2Y0Ye0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/04/2020 08:18, Christoph Hellwig wrote:=0A=
> On Fri, Apr 10, 2020 at 01:53:49AM +0900, Johannes Thumshirn wrote:=0A=
>> +	if (req_op(rq) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>> +		ret =3D sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);=0A=
>> +		if (ret) {=0A=
>> +			scsi_free_sgtables(cmd);=0A=
>> +			return ret;=0A=
>> +		}=0A=
>> +	}=0A=
> =0A=
> So actually.=0A=
> =0A=
> I've been trying to understand the lifetime of the sgtables.  Shouldn't=
=0A=
> we free them in the midayer ->init_command returned BLK_STS_*RESOURCE=0A=
> instead?  It seems like this just catches one particular error instead=0A=
> of the whole category?  The end of scsi_queue_rq seem like a particular=
=0A=
> good place, as that also releases the resources for the "hard" errors.=0A=
> =0A=
=0A=
I did have this in a private version but it leaked the sgtables in case =0A=
we had an inconsistent wp_ofst cache (I injected a zone-reset via =0A=
/dev/sg so the driver didn't see it).=0A=
=0A=
The code that handles freeing of the sgtables in scsi_queue_rq's error =0A=
handling won't get called on BLK_STS_*RESOURCE, which makes perfect =0A=
sense at least for BLK_STS_RESOURCE, as if you can't allocate the memory =
=0A=
for the sgtables, there's no need to free it.=0A=
=0A=
The only code in SCSI being a special snowflake there is =0A=
sd_zbc_prepare_zone_append(), this is why I ended up freeing the =0A=
sgtables after it returned an error.=0A=
=0A=
=0A=
