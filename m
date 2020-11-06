Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DE32A94BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 11:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgKFKwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 05:52:10 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35287 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgKFKwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604659928; x=1636195928;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AJ2++Zis9OeqJZfEJlPY+FUmWWNAlkD8o01zegdGTkY=;
  b=PRYFb3olyYrUOxfNdvuKKmv1/rNzZhDNKR3LJGxNEtOMfsHfarnxz7tN
   oEnzyKP4QkvUNZXUL/LVPVWu5xHCrMC4hNVGg6VB0y3V6pLhYZQ8yh4GR
   zXxxIa+gcEeCkjpG0bMBO9NQRZtRjfwvgrU7cMwr/OwOqP54SOUlLisIv
   +s+BPgDGGvNvDHKgFophn6/Miu1d4RHeUD4zSMSQ85N0EsFscoGm+epyC
   2Vb5QnNQY6yCYwmG4l1CezZkilOCjjinEFuCSbfcdEytScIgSDnKCSMOS
   ALyzi5cJLhMhzEKip9TkipyCHNSiXejJSbjh6ZIZ9BHXAc4+F6gFE03v4
   g==;
IronPort-SDR: HL7vgSQBL5G4SstEwBlAZWEu0/AJnpR7jA02ZtDmtJnwIPUg6kDXRie53yPHWw80xM6WqU4Qgr
 GiTevYENuaGNlXWae02iLW7gIWzjZHZQ14/9Zl+/s1h9o/qJX1rqv1C51x3TlkeO71cSUm/qLF
 zc7k+xmSCWi8XChZOrtwvRfGxqhTGp6a7Rg1mXpcDrbrVgdRI9meucW76gK81xtDZK1fVKw8xl
 dZPCx7KvcEEqY55aTDGBkuweSXGmi9MlhTwuXkJgkQbhJW1LSp5p2oJCuWuOD4tiEN1x/ckNOv
 WkU=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; 
   d="scan'208";a="262014934"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 18:52:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N62LWNqhfejf+ypluLfRUZ0qLff4UeINnzs5pmZIfidXt5OqB3jLZlHD2V+4Ls+8tMG+5c87IJ8n7HqU7ojELG3EH0EtbV0YALNGaizVTQYAOzHdzMC+s9qc4ZnSjSbZq0Jetud0bOjjJzO8OhWMYxz5VK4dW8Sgu82WlKIBAKUtM2jyjpSBLvV0KRqqbDea+rEO8XUUkvLmwD0vbbmaDHTTkgWeGA10lPYU94bfwgkvZro+zSH3gWrklTehxjbDheDOxVVAPuQyJzrnh4vk3kzdlblLpF2396kkdXRpyQXt71a8X829jnqgNrdcE9Boh8dZMnHe9+Xj2Chlz3aRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLf5HBkEqYscReyDGSYGJn6XbeIylMaSyk5FrDva8xQ=;
 b=LQdcsLZZRJZ4tynWmNZiqUJXGWMOdgvHVGv41/5P2Yu6WGQt+smzPiPNdOdaJRaL4ALUa96qBc8HHeB5+VLOzhpyH0+tBElIk1S6QbyHMAyN5Tw79vod9Kvn6ItRtVyn05CdbK7pkAmIunU+FaRocTeq3t+rJR74r9nQxaCg41N6jLiwfxCh05dONr5lkg70uonlbvKbKdt+6eFUlN11mwToHzw4GnRLDfhZcVsYYFwG+RQJ30rbCAcFeg7qb/Dm2+/g1hyziuqYzJjD/uUtFBc+wzXg1EZYwwvBzNkweW5IZDsd/CiIk/BkHYnT+tZcZQLXhlWBe8ouLl0PH5OCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLf5HBkEqYscReyDGSYGJn6XbeIylMaSyk5FrDva8xQ=;
 b=wKI61z+UuZB8MSemsNTv/e65GfookNOwdwRJCcFkGJ9evglKyBMlVM9jDyVJK3/i0bw10QJLWl6GtrsCZEJYXjSUxhtW8pkbnnkdHjGS86AUbRNjiohLO7L2cbbJR50Mqw+6jxfzMLaL/yEmP891fpWg5oU8jbaBpcxnCeJ2Pgg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3807.namprd04.prod.outlook.com
 (2603:10b6:805:43::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 10:52:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.021; Fri, 6 Nov 2020
 10:52:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 24/41] btrfs: extend btrfs_rmap_block for specifying a
 device
Thread-Topic: [PATCH v9 24/41] btrfs: extend btrfs_rmap_block for specifying a
 device
Thread-Index: AQHWrsQFQ5FSC5E9oEa6DwGPUPbmcA==
Date:   Fri, 6 Nov 2020 10:52:06 +0000
Message-ID: <SN4PR0401MB35989368CA2E517DF21E28509BED0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <3ee4958e7ebcc06973ed2d7c84a9cf9240d6e7d7.1604065695.git.naohiro.aota@wdc.com>
 <d1636237-79d2-e13a-060f-6a9a6764da4c@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13285177-06c4-4594-6587-08d882420112
x-ms-traffictypediagnostic: SN6PR04MB3807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB3807492453003BEBEDB310379BED0@SN6PR04MB3807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vrGEnbvpBMtfBmy2n1hG9JhEmWI9MziX7ThsNXqqLlkzNKCtgVM591Fc4rQyv/yftcwIq0pU6rPGyph4y0g6mE4LmdE5wS5zwyYpYuAMhoh/7RSO7AGETrEVeL8Juf9ub+YsfJFAbjQC8gip+/mRQUSqppZV/WhIHZomVrm4pS0LxNZhqO7pyY4n0bO3eGLABNF3+gMUXmCxA8TPw4VnUiWEor3Qnr3LBwCxeZpRXH31PYd6/7iBNEY7VUuC3oS+edDUnvhb3f2di/P+6duieIYgl5whDfvWL+bNtKFcEmsl4BCxUIFJ/HLs7tTdw/t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(66946007)(66476007)(316002)(54906003)(76116006)(8936002)(33656002)(110136005)(2906002)(26005)(64756008)(55016002)(86362001)(186003)(91956017)(66446008)(66556008)(83380400001)(9686003)(478600001)(5660300002)(6506007)(52536014)(4326008)(8676002)(53546011)(71200400001)(558084003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: m1OFxnBr0/YQFzh2+BTF9u9ey5pgSoW6LqfxkQn1LVL3gAvjNiAagaJGcncEou8QqX6CTn1cRdZ6JgmTxbL4K/A/5SBt+BoHRlwa+ywmN9mtQvYaOQVwN9f4JcqTvKvz/ciBjjuT97AdFOXPuvVIw81FXT3ZsDBkN7iS3Vph5dafhoAiCmfoGSI1F9WWZkIyEGCiTrSDxFtv1vn4sIwv9Gu3y9bsVnWMCJa2lCo34i2gaQf+du80ntXAMZl7F4gF3coePmBukBvaXQJMHW7LBihgSfzjuaPEkqdP4pi/bL9hAJzt1TVkno5qRnlbkJSGbVo3mjXTffl5Sn+KiNErjm9jCqO3pVOAO8s8ywY67ZdAm92ZN91cxbTxykNJnFqnkPQ9MqNPS2G3CXWQeFUKp+oGhUgme6L1XXm4pgFT5fVbketcddm9H5KQ9G4nbUG4MPru4lz5LrGZkwim6QxqWboOpCKMLLqB/U8mk2FGk+N+C51a9cEFmiOT3Qa6lhQsqSi5s1k35+MkW1KMmB40dMjxId26kG/VSqt9mMx7PVx+F6u+QEHPw1WijJKlz74TrTUhjrVHYzxoJQDgP2nZIP4zaboMVQ+MyJQeP6h3MQjpmoieeYYjZmpKMJOphCUYdkqbQ6pcL0c/dhsFZu16rw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13285177-06c4-4594-6587-08d882420112
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 10:52:06.9472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcPbZpV3PCK84xB1+godhAMdKJ/9XfXtGH15DjNY/0hdBTKEa1s8pMVgEs5FipZW1GjH8xY++mYKNzIofnMJxvFpF91103N4HKT5ZtckPQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3807
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/11/2020 16:32, Josef Bacik wrote:=0A=
[...]=0A=
> Since there's only one caller of btrfs_rmap_block() in this file, and the=
 rest =0A=
> are for tests, you might as well just make btrfs_rmap_block() exported wi=
th the =0A=
> device, and switch the existing callers to use NULL for the device.  Than=
ks,=0A=
=0A=
Fixed=0A=
