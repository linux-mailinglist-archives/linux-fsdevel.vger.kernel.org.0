Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085401548B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 16:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBFP7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 10:59:10 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2084 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFP7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581004751; x=1612540751;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CoXR+I7ujXVoFemZlueS+1vp64JBtZMUnL06RD6c6asrEv/dpvGBRR7b
   zJPFT5eMWfjKYJJjrzzz6QJFG2lEhS91/+s81GKzRG5yxlMpa6PTBX1PU
   Nsxv5do5UIPjC17oJgiMHFXGV2KZVGfvfWCergOICBz5ZfGAaX24zZxhp
   nKdg/BoIKiA9n09D3QlDSIYgQztiOMIB9tn46TGwn+1jcyAB+FYqsgfDw
   LKdR/I4a1LPAH5bk+ONevxX68ve8pX7v8kU/BLzRRJYzSkwNz23fN+Udx
   /08NQwrZs3aqCjM+WcmpcGcsqCo1MwsDinwtuN84cOTuguMvovOnp+pY6
   g==;
IronPort-SDR: +9801xdKhitcHU+5N55A1c+ffe7f4zqJFq/SLaDwQppEIa1jDB70GZ7kvbtcsRE/niy2xNH5Yq
 a7L+OhDSVeAy0LK9U/ZfnjtRVIQZdmuaaYzaI1LBG+d9VFjWpaW+NxmzeOA2Jldtt9QSgZ+qKR
 w0QCIzFlUQjnwgZbIYu7LUc1+dFXiB2LWYUie7OxnpyvryDpFFo0dP4D0mQqSPjQJnMiHM+v5A
 4upvfF09BCTTIdUmlIc0TlOMmdoyzWc/lW1Rb3jxVvwL+OxEQSJrJ0m1eBHcsM4XTeV1tTNh0y
 UFk=
X-IronPort-AV: E=Sophos;i="5.70,410,1574092800"; 
   d="scan'208";a="133614847"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 23:59:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnlLiOtCQ3OnRrCM1mMUpDxKXtURXTC6565u8TVU72rKG4hojLH2XiHVZRmX+UcqC1rrX9Le2mIIM3+tax+inuK/4VGN5/oaAjCrndtQCCL+RXqYlIL6bDW6SksEVCl2p6WkeCSpvdHwS/iQ4hT554u4aFudHjgZJqPUmJHGkG0yuSuruyaFVkaTKqXHsN7JuhEsnOCppMgQ915m2cNpf8f8SUwAJudhQJ93IapYs8EnrxCGYJTf3LGUW6OiSuaj1ekoB71R2wNZBpKDAO7h5WBsZH0yvU/v9RaP+LhTN26FZ3qMUGn487WkdQoq50gb6H9rh7UQKX60hwGzkdFr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cm3/XKyIkVUrD+VoCZHhe6dp3mgXcN2Bt5ek3g+kD2G9W6LRrx6JfrImnLLR1XaSmY9qqrNLeyQqer9nmDNVbjHBz0Rj8lbkuXwQ5c7lTI8vhTKeP52eUmahyZkL5HLWUOpgDNaZiG3YJLpmHSi58wneZu2Vuqg9DNBSsjxXNzuJSoa8Ae+pm8yk2R4zbS6mxD2PsN1+JweBPrwTmn4ecsI/6l9D/a471aFud4gFmTVhIwUk1lWrZO5AfHhnVH1R43XfIFSoV00GVksy0DqBTPYx8UJzTGXOO8BQEK8TO9rchgf7pGie8Ar9JwZBVPMLPhmd/8msy/zmW4l3s47HMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bNncFjk/Vk819j8wSlIOs5r6rEy1W8s8FT0ZkWPjTAFDnehuRAScU3kHX1EVfZENkOE2A/UKUd5go0nsuRekkKipiDCtusGcuUiPh50Y5kxT6huFB5tk57l9vSJZTjvInIQecPK7b94a5CWDY4VU+euZEZIZ3KixqOOvXxhleJI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3584.namprd04.prod.outlook.com (10.167.139.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 15:59:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 15:59:07 +0000
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
Subject: Re: [PATCH 07/20] btrfs: factor out decide_stripe_size()
Thread-Topic: [PATCH 07/20] btrfs: factor out decide_stripe_size()
Thread-Index: AQHV3Npsyc0aUq71AUCuJ27C8JKk3A==
Date:   Thu, 6 Feb 2020 15:59:07 +0000
Message-ID: <SN4PR0401MB35981CB7E4E281D8E39E30BA9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-8-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0a871cb-b242-458e-a7cb-08d7ab1d7f63
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3584966803253AD5CA69C4079B1D0@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(5660300002)(52536014)(4326008)(71200400001)(4270600006)(19618925003)(478600001)(91956017)(66946007)(76116006)(33656002)(66446008)(64756008)(66476007)(66556008)(316002)(6506007)(81166006)(7696005)(26005)(558084003)(81156014)(8676002)(8936002)(86362001)(110136005)(54906003)(55016002)(2906002)(9686003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3584;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+AGLxm99YqPg20Aokkci0v/BotkCMmreukdudAEyHUJw52ZsKF0EqGqCuhJ98Xzi1GOwfgSvkkuTt16y0vJXKRywVgx92C3iyc0ZmitIpMOd3+poR5bEcnzBfMyqK7W0lnFgTeUtcLn4Bkl51MqxZIFqXrK+AeAFfejrphCUQ3VC2rHGd4cn54Ts6Spe2pfHPVSheCeZwJ4xTq6sLFt9bbSRizKk3M1DrKP1vr8JoQcKo/cDWvDNrDbz8FpmVIALS7DJDbXjAbOzkcIfA/aWgRZYs63bnAqtbcCSFZqOZHvnrEnQXKv3pxhPZkqsfWxGbzA+B8fkwsXDESKzlgv7g7JjMoMfdNocBqh4fdMymQZ91FKGQ4BeC+xzdbF9rdAupMoi+rgUtO4VGOGyMu8zM71fzpPBJSkuKam+rL4vg+bFA6EWXdoqVafKF1OZm1K
x-ms-exchange-antispam-messagedata: cy7EuZZV2mVRyERbOvuZ9HjqC9wEPiEiYzRJzwbc9vA3G2aWm7l7TtOPVOziK0l9LH7KEOc8/wxQIX3PeGPess4yIHwInR23u3gOOgULZ9PIk7FEXsY81lf+zKuIJde9r7Sh5BW3yMlFK+taHA8Y5Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a871cb-b242-458e-a7cb-08d7ab1d7f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:59:07.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxiLtwfVrZXtqxG6dKa5d37nphLRHiNySqklQXRluHHONiLJGTzuK2GlDxQE9d8pjMtgwus2HiPGoIdnCm08elb0OKZqmnt1ycE1SSVOm0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
