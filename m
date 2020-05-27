Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995871E4CB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbgE0SFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 14:05:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58140 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387706AbgE0SFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 14:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590602733; x=1622138733;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=g5nuOytbkdnVtKnQy58zG/fe2zBg5FJTM3s277N6WsQ=;
  b=BwrYgp1fg19+OESDWANHO/asEAfXkVjSfWr48gzJrAk8ee+7N81oKN1N
   I1/wi+mY2zwVGFkv/QR3h7h4xoWHqW2edehb06YS3M3FH6xUH27AEvVz2
   JJldg35lQCtLBEphK90PJDLpxFXqcDHadCeNKj2SUmbm+vTwdieTTKHy4
   omQlFzrlXtRpWGdgUypbj5MOIYldJU/7Smq3bs33D0viJqSgfLKEzyW/C
   8zbZGd73OBY4I5wH1gya9JIHHgByjCeXVnLSNEcMEqvUInOiE3HRSBz0G
   Iinb8XgUxQNRAtPkR4bgcYJv1Vve53hYJZzx1TN5VcdvxYaFI1jvS+EtM
   w==;
IronPort-SDR: 3vP4prG2jeXoMpaew6ilkjeZaNPC0AwaWCgl4zPYTMG1pigH0M2elpYyvqFedu81aDHnXAvf8i
 091ayvGfAXCbEoHhYPJ+Ah/RfGBM54sSgnZNl0dJaCFKn2iO1M13Vwd2IJqhg6LMbE6iN/qAwT
 EezgdIb4QyRETvH5Owpadt2AE7BTzbKp0Srr4I2/tl4LA4Yk9wW+HNvd3+Q62GIpm1hcrkQ69+
 M/OgE8MYTpKKBo+dVxO+x/FN25RX6H2dubk46bIyMWQuWs1wzh7Xeq+EbiOl4JFs2NObcH1/Uq
 w6o=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; 
   d="scan'208";a="247693619"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 02:04:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7k8TGudKK/pyS/5vVr5m8TgU8p38uoNu1dJ4/++UNkFQa2bBUArO/cgQHzWq6twJPArMi/cBf6um3T9/jy8dGedr6gVwuUStgyvZ7pA7GQC2YgguBzdgtPrrBBqdiCSRpNzGIqlrtHdEA9A+j9u8rpgIQA8N/MtrHquUfa3qYq1j3bSgFWL1ufpCjAx5ZMKC3r6tpBpO7mAz5QC/Zw54LDomU+w4q9prwjyYGp/uKFbsS6d8zA7zW65lR1tspe04fnLZzeneNWRRc7X7Bas/a6X3G/EiH8fMsCiIiOtwpG0qN5j9uIJAJwI7tSJjYYPMNSNdoRIBo6vJg3eqRWwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5nuOytbkdnVtKnQy58zG/fe2zBg5FJTM3s277N6WsQ=;
 b=A8g3FRODjJU1bIHtGPY8kbQUzw7n5xHj4hjqnCbEs/FYYeTLm7W6VnQPbh1W3j8J/ZUicYkYi0kBeEhmk7G5CqvDfSoMXM6sREXhepxlbQqJg/Hd//vbxKgsLw59APl7oxzkbZLWgp9J5sutMf89Wd9rZI+Rc6gw72Ra6px0XzTuW2ukvLGskI65HNORghLOktE3WGs1QFBCzPhtf8oAM5E0GjgOB0Bd76kAdLzYKE93mKAx6jxDz33g34zL0pdVhVqLpe0nHC+maaYJNtKctUHcW/lGveqelyJjiCGAE+lEwv45lbKlQOOmH5KJ95/GImR1Mh0YXSOVmOy6JE311A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5nuOytbkdnVtKnQy58zG/fe2zBg5FJTM3s277N6WsQ=;
 b=YrPb6GhDE7/N3HoLI++MCzvDkrxY3dtuZ1rXIcNzIe0Sd0PJph9zLQq9/Zf4gfvSwiDxst4u54UuWZSz72wmmlrrCPko46nvllHNIvZQcGEl/CjvCCRJkGFjMCSxH5uytgslRu/Ufb3MHXx2wvg3VgLFVy8BJU+SdzeWQlOBcPc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3568.namprd04.prod.outlook.com
 (2603:10b6:803:46::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.29; Wed, 27 May
 2020 18:04:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 18:04:57 +0000
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
Date:   Wed, 27 May 2020 18:04:57 +0000
Message-ID: <SN4PR0401MB3598E973D98DB9A0363BD3C29BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-3-jth@kernel.org> <20200527132428.GE18421@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53faeda6-aa09-4642-fdbb-08d80268776d
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB3568EDB7DC8F1EF4223BDDD39BB10@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T8GsjkvPXlgIwitFyOkdJAhHucjTSG4tjGlaIlDYAuv3KaHMr9KlBzL5x+Hirq8P86OU6XD6dlmkNdlfk+5b66qIVycn1kVqvn1g26GnmYvuYgIrZcVFPdGsNqoyd5cQMiru703NvVqKOkVemFuFoRG4y7ImLri8N/Rqva92MyRKyH3HBSfcgX2goK+pnaEZP0vivmMF6TpRlqtIGTLvsSHLIC5KhmDeklyLWuCdy4+W5xDRtzw8x4hPx7XXWoJr8xuxyMNDBzXcmPKMw6ZH+7Gumpw6LoEfge6IXeVogomSfi9JfOCqILbftdVTtsRmQKk9UyBcGsfw/wsw0OTllQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(66946007)(33656002)(76116006)(66476007)(66556008)(66446008)(52536014)(71200400001)(64756008)(4744005)(86362001)(4326008)(8676002)(478600001)(9686003)(54906003)(5660300002)(91956017)(55016002)(8936002)(53546011)(110136005)(316002)(2906002)(186003)(7696005)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7BMwKhih6R11QCOHdYh2ngcLpxYTEUL0ou91sZoDNpS7Nilxy8J0Novw9gITLN8iurP1iSjQtprLcEZMG6Ws6dZMBaJUoPNZV9vIxIyQFpJJXE7XEHDTL4ibM/MlutoVL3lOBCo1Eh9MLnt9tkG2LO2K5z736hcvnKBgj9G9bD8Oweqc/jkivz9ImTBFMFcdHm1V0t6SjheJFHuZ9+9IOx3DGgp0geVHXnMc8aIkQy4ie9GDzbccKOnIoLnzTu2yv69J5eg71AOFjhxuG6MxutejMbKmpQp0LogqYwl+N+AucA9wkdoudsTagsP8iizBut/Re1GXYHhKdCyKfmQnZesUCRQHQEdvy6hGvPTOkzlmbDeaARlSu4FI+gT3SjbiT06hH8Wz7if4otaoCjia6mLuX3uIAGCRb3EFcs8q1NgXEb9wHNKX4HGuIMnNbyQp85bx/2SqQRf7yteYXYZ8QAF5iAhHUI/sfX75gFE1n8q8+l3OchURdrrXEsoF/ONj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53faeda6-aa09-4642-fdbb-08d80268776d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 18:04:57.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaO4TDrjP2Dpc3Qslekc44QVWSO9C+6iOvSKi/xUQZNaF9RRclwt4B3//QjpnCsSgfMA1iiueAko/YjcKkcmqlAVMz8Oo6yiPVj9YTQpqII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/05/2020 15:25, David Sterba wrote:=0A=
> The key for all userspace commands needs to be specified the same way as=
=0A=
> for kernel, ie. "--auth-key btrfs:foo" and use the appropriate ioctls to=
=0A=
> read the key bytes.=0A=
=0A=
Up to now I haven't been able to add a key to the kernel's keyring which =
=0A=
can be read back to user-space.=0A=
=0A=
How about passing in a key file, like it is done in UBIFS? Should be doable=
=0A=
both with libsodium and libgcrypt.=0A=
