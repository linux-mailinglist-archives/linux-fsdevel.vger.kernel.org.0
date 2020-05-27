Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85101E450E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgE0OBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 10:01:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34646 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbgE0OBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 10:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590588070; x=1622124070;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=37o+rcbdWqZPIFMAxycNtMaToK1xggLt9fY4Vha41FU=;
  b=qtBD0B8H4YpSSJ4g4RuveLwe9ufIeZfBqr6VJYWcIETtVN7RALu/ny2s
   lLU8Hh50JaDnZBSqiESPFg2tDUi02CHrRf/xopW6N+gz+jZJiiR71gnRn
   T1EiSesiYWS/y8Pq9OZnGwn8ioBZmGTPxnhEGNTPzSwmHTu3kh2WUa5QS
   881SR2idkDuwfgKlDqjOSrAPQGA4BpNuIkQnML8nPhJopCXJjDZbKgIFT
   LuZl4I/wqy37pijPSx6gKoiienwUr1cAWsa19ZgVRHx8WazgVluZbd4ve
   cEEPPi7OmqQ2JpaEzzYWnwEXdLmkb1ex5idh/8Bm9RKHFzmb6Az1HCz7j
   A==;
IronPort-SDR: QMiTE8vXNH5mfUeovK+xAXhXjj90JC0xk08dB5lx58UEPOlToqQG4ieypPRIsWgLyiSUMGWcpc
 PJNRmRyhfuE8+24YgVrzvBV/207TG6n01lff96aYvuv4c7fLHs+d5a5nnmyN4A1Rlqeky8+kOx
 JbOcXYr17KSRa4l8Nt7/7NntYHzYwwodCwRnv3Rpyh4ojj0S0VPjqq5+dsRhmOiUf3F3nJiMUt
 jbqPtZKlVEpKFvR0nAu4jWO9wcV68Gkq/oCoXjadxn4q7WoC3TLjSkQuzzyHTh6dVM9NW3RdlD
 1Yc=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; 
   d="scan'208";a="142949954"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 22:01:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAazIeOyMnYfX+lHNMWMqyvnm4eWtvNTUrmKuURRa/rxf8XgTURVKSs0jAvLSL/sld0kIMCkbPkYSDK95FztdRFhgTQWIoWhq/14iX9ZiZtcG6YAbD3ATEkqRXt6/2QcDEW6ZvzDAUucuHlj9MioMZLDy5VYLDzeKHqvaZyRMUoQSsOQ5LHBegEJUp9ITl5f4s0BS9jcuK74m6XLgAfH7kEkxo9AMtKhYVA5PD0Sza+WSAjSn6hHWSCLMR1oIRly2Xjh3/KwWgQXa0lQbQesbQbS2qbp71Eli4Q2RomCgNIl9GaNY04UjIi7195618V2YSLbNspDsHWprrxPEHpPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37o+rcbdWqZPIFMAxycNtMaToK1xggLt9fY4Vha41FU=;
 b=RzLk0SM7Ipht95tKNgmvrpzQrEacbUzt8uK1KUMbFpGGGaGS+wlzGT0aZBsweGSs+i65wDPgrS0J4k09kQEh7YoeOC26U9USweK9QV4y+I5z5YuixYE7ZocVq5l8JccMr9+Q6WRKYHTNvQNm1TguPRkuOHVpuJLchtzJ3VR+1LU87smJXz/MKjoRa5r/k/YVKQePMU1FONMBpMzQsDwNdg1HLZpAnhTLnPveanj5pNDJ3TNzW5Qjn/mS0Goe7oky3S6T1cDlGSEbTPMA2TZtSvepz07Qvay8iCaiccqsziY+A+LhN+kZWPzLihECGBhNWVG8mCRi9TNSDUZ2qMcl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37o+rcbdWqZPIFMAxycNtMaToK1xggLt9fY4Vha41FU=;
 b=DftAuj/U+DbRhgXeEhx0RmcMr3wG70IwtaGhyAS4oRfCKkl5s90UrNWOLjsA4KktayL4s70QxAJHI2w+3LTq+CaasM+gvfS9YIeX+T0ijVpPVP0y57ELlxMDiRRo02KBz+koNCQbBgPU+qY/hxMZtxiqOdIySu8qXGe432sNc14=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3647.namprd04.prod.outlook.com
 (2603:10b6:803:47::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 14:01:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 14:01:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 2/3] btrfs: add authentication support
Thread-Topic: [PATCH v3 2/3] btrfs: add authentication support
Thread-Index: AQHWKdGCuxq5LET6vEqLmo6XtFxQPg==
Date:   Wed, 27 May 2020 14:01:07 +0000
Message-ID: <SN4PR0401MB3598B80EC0672F413A6796449BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-3-jth@kernel.org> <20200527132428.GE18421@twin.jikos.cz>
 <SN4PR0401MB3598593BC0AF9909CC1986889BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acca8d95-3d1b-48ed-8057-08d80246671f
x-ms-traffictypediagnostic: SN4PR0401MB3647:
x-microsoft-antispam-prvs: <SN4PR0401MB3647749D6A7E7D520AC6B7509BB10@SN4PR0401MB3647.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EE3RHLXaHLopKVEqAi+7+WdJmX2BajoO+AwtXUHKwIc/9G2jRyQ8qHhuDyKxjv8N6u7pRH6/FRMcy+mUCZRHuc7L93RUqSau9OkyEu8nURiCZMmJ4s+BAICf/kvecPwBXeDgUktakBmiRoL3uncXaT6XHG7YpOgqxoeC/PxvC7C2DsM73opVHrijzpZW2gLHgrfT7O4VKukrKSRT4IOCcuBbyu+UvkxsASmHZZLtdz4T7pquCShiN7rRPXmH+6CJSXrTGD50MD287EPPxZG8lCJjxHq7TpAPG+eIEOFkxZGwnH7txsHpe8wPc4+Nj0T5/lC5B+Ix4M1r8CmCkK8W5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(53546011)(4326008)(52536014)(186003)(66556008)(26005)(91956017)(8676002)(66946007)(76116006)(64756008)(66476007)(66446008)(5660300002)(316002)(4744005)(110136005)(33656002)(2906002)(54906003)(8936002)(55016002)(7696005)(71200400001)(9686003)(6506007)(86362001)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V34jWWNdv9wn2+u56pnyDY1/PiXS8PIkM8czzNipzEUHcWy0QJP+0XjKRH2BDEzbP6cXy/rK0oz9qinaR0G8yEqYxdh+3m5eNolH62faxvVnDWKaKXC0th52oYZrgVrGNHn7WOLhaQ9GZfLyKZMHEZRxc1AtEN7THvIp3YgMiQqgNBYzACB1++OC54nYetzRNVqLJOGBd1mnfRraQkXUiIhJeXl8S+de+RJahvLmc9v1NERhVgOJaULzd3h77zaAfdYYDwP/jPjNaNU4bGgVLEjtO6MYq3ZdzKJL1g06rZYnKvSBOQp01sVOaUxz474Ir6Mv0UPSY2xS3fre0qZ5KkeP/2lrdgQa6WXh3Z1sPjmv8EUXt2ZspWKUo/CLsu/o96NLubwMCVXLaqV8PoyqPKMYH+bKDiKJael9YIalkPNRUv/Vxj137YDMUY021d5u92vYWdUJLWzraS7AKrEFuMfxOiOqT4PiOsBXQ8nAMhEJipHuqRG/ByuiF2ipZuD3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acca8d95-3d1b-48ed-8057-08d80246671f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 14:01:07.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gG9mrbMfZfDm3j7+7LzUnBPiEGmlWVZElGaRq04bTnIaRyV7MvfJdpg3m9MOdfBb0waXVwQ7zAOt0QFnz9sRGby9LdXL+s/HFg93ZgK3Sqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3647
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/05/2020 15:55, Johannes Thumshirn wrote:=0A=
> On 27/05/2020 15:25, David Sterba wrote:=0A=
>> On Thu, May 14, 2020 at 11:24:14AM +0200, Johannes Thumshirn wrote:=0A=
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>> Example usage:=0A=
>>> Create a file-system with authentication key 0123456=0A=
>>> mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/disk=0A=
>>>=0A=
>>> Add the key to the kernel's keyring as keyid 'btrfs:foo'=0A=
>>> keyctl add logon btrfs:foo 0123456 @u=0A=
>>>=0A=
>>> Mount the fs using the 'btrfs:foo' key=0A=
>>> mount -o auth_key=3Dbtrfs:foo,auth_hash_name=3D"hmac(sha256)" /dev/disk=
 /mnt/point=0A=
>>=0A=
>> I tried to follow the example but the filesystem does not mount. But=0A=
>> what almost shocked me was the way the key is specified on the userspace=
=0A=
>> side.=0A=
=0A=
OK I think I know what happened. Did I forget to send a v2 of the progs sid=
e?=0A=
I changed the csum_type number to not have holes in the array, this obvious=
ly needs=0A=
to be done in progs as well.=0A=
