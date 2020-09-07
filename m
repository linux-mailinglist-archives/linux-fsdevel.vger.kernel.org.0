Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBA25F6E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgIGJwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 05:52:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63661 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgIGJwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599472362; x=1631008362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zGsJjl1U97XUSnJSgQbXquI542FRVToQx5vHYOFQR7U=;
  b=i27ShxSUcU2Bhnh/dIbZFQKYOiRxQ4MD1Cxkqs8kGH9T1Rl0MGYr/E2u
   VJgk8a8Cy9RxNJb80bhcgeyUfhaFM2jL/eX1j3yKSysCpLzyODIDsb+8A
   gzlm0QKdh28jBKNsGSRpWTa0uV25aEAZZFEBVjCd1vi11SIQTLitk2le4
   WDLe/UC/ivPLLESqwrFKJNEBctBKqWSKvdCpOSiDbsUBjH0+fdY6UD4we
   2qMq/JBJ4AUKjVuOiJDQF+pzwZqhqjkvA/4OK1ZXgc3lX87ksdzkXNZML
   NlE7DJ57c0g2cnZAtUWBaza5ZeCs8Sorr7htObtoendWkA8GVPQygdXtl
   A==;
IronPort-SDR: cChrchm11SLzkO3fqwE5/Gift05A60MOErMrMmX6tdnnnRm4Wa1SPKXRRM9HTyKxgp891dT7sa
 MtItf2+x1qCJAgiEte/pVpAKVoCxY0Rl7kqae9sthmMABo5FAs6O9hdUwrFB+Rz8Fs+PXV9l7l
 NIoRaJyOGcF6FRbZsn33LJgm+gNzrfh+2ITH0DsSfhILHzKq73wKgfHtE7IvoMM9w2XvTe/l9E
 V+2xorx5P99QWTXKRTeWvFzlMuJLhRVYW8eza2f9fo3ii8PeRBebAfhLdpYgfKfPF7xPqFAH/8
 9yw=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; 
   d="scan'208";a="256298355"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 17:52:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ8FZ8KqpnhC1tLrizHp8CwPEwkTsfJZ7jGNHm7O1X9VYCjLIPNCiF0QgCW08DX5Lkgl/rVPINl7ideOeO88WZCq0/SejRRAtmH+9FY87k/nIhnP7rPyL0t7xU/7T98rnAv3scndKZhaTbMLOBCJ8mkJKOM12uCDUkbKUOqRMurjSI2Lc7YVc4d1aS0P0fNzdNxTLm7+kc06d/GBfwDhcGrTsoNSdebhWGabXbxX9Lsfv7yQONBPEAwXhj8sOkyrAV/GBmmxzqGIp05KZqkqnqbso09KOSp5VAquBau4t3ygDAZfvp8fGH5z5dnJ1ImZm6tmDa0oIv2Vv0Yq0ELL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGsJjl1U97XUSnJSgQbXquI542FRVToQx5vHYOFQR7U=;
 b=X116PQk0Of3TNdXtQjeu5tQ0Y3ZGFTeU9UZDalJJ+cZX71jYaTipVN+5Ee9Ype00a5LQIk3K5nA0HQjOM6OWk0CTAnUJyC55xRoaeZKK6Z428ITbwUOPFfwqqYvwsuH/3qxaAzRxBfsqTe2wt01wboiJpfCRt8+jqWYYmi0goxsfAkS4NYIuQkFxNJFU6yrV7+0JDgHiyba9i+t7rh0/Qgxnv4/MNJ0AfcAgqzJ5NCHAFwXdKWG5GASCxy1Sfo5sMraqbE8xyZXGdvAFyfRG1rMrS/f+u5oIjJL3CfRqWy7+lCJXk1RrvmQMvfsP9PaaxUL5G7CCJ5K4PZLIB3bVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGsJjl1U97XUSnJSgQbXquI542FRVToQx5vHYOFQR7U=;
 b=nCRFpOTqMGKNoQWyNSAe38Wyo0ZHE3qMgFOurlG31gJPa/Cf70Rq+ty4RQkK0Tzo9LNrxjTR/lcj6isWvP7ShVmPx4b9bkpxgz68vKzGtOJBkPPofYwBq4epsHJmdyZNyeOFVg/oOOW4jYUqNWljaWT9ffHCOHae17d7eVj8qWI=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 09:52:41 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 09:52:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/3] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH 2/3] zonefs: open/close zone on file open/close
Thread-Index: AQHWgq3Y4ys/PNxBsECpyvJxgruBJalc8+MA
Date:   Mon, 7 Sep 2020 09:52:41 +0000
Message-ID: <982153fc92ede2b652e24cd022180e59dafab9b1.camel@wdc.com>
References: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
         <20200904112328.28887-3-johannes.thumshirn@wdc.com>
         <CY4PR04MB375199CF79949920633AE2F1E7280@CY4PR04MB3751.namprd04.prod.outlook.com>
         <SN4PR0401MB3598E132449AAF0432C909E19B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB3598E132449AAF0432C909E19B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:62d1:16e6:ecb1:d604]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3c47e17-c936-4e11-b730-08d85313c30e
x-ms-traffictypediagnostic: CY4PR04MB0968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB09683EDC0A33ADDBAE91BAABE7280@CY4PR04MB0968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IC4clIWIDP30AQansk3NvqHfoYXPjTrvKRQPRXEz5gP6etNq2t1Fk95EObyVeE1KEs6yVOFWgmPmCwafE+DjEdicKrwyr9mhUfn/g0wdAFpxhEVJ93T1TbIjQI3p50HDTOQzbjCO0cezg0AF5Go+/gJLj1zRONzOg/I6FSEeybq8mgkkSELm/OCKqXoLHeSbtLFxoRGMydOSz8T8PLYwqpq8cC8k7e4KwpC+3jMDy6uvCrhdmr1b+sp+Kxea8ETm/r2kv1A33fRQPu9qCM7Le9J9ni3ws7E75pWwp/srfNpg3HOGhrIt/aLWpw0FXbKFoUT/SFIfmmXZ5GrCaK723g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(6506007)(86362001)(83380400001)(37006003)(6636002)(478600001)(6486002)(76116006)(66556008)(66476007)(66446008)(4326008)(91956017)(64756008)(316002)(8676002)(8936002)(36756003)(53546011)(6862004)(66946007)(4744005)(6512007)(5660300002)(2906002)(186003)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: puqXrAXxgGKIRyucFh68odYAJ9KOQsGqkEqPSSSV6pTxWf4ywpJ0ErteSeZnVFeOd1kpew4J88vzZTU6xi0HN4t1CpFQM3VAoFORMB3WQmF5U3GFcqClrJ4fPNt9lR9BpyuIe5daqtuSpkFOesvc2JUSrS3D4hxxY5pk+d62fibbrEEyk70CrYJaK8QjXeQsa7wyOu1RrcUQKeJ5wOGS86zVXr8neZ5/wzhnVXtS8Azqc8Mb1HCiSpc0BoqjtcRF/zTUmR4cAfp7/cvaGZ/ftzUjK2qOepJbpIyKfWsZyEWdFaiFLbg69IcXGihcqSySrkRVHfvkth/sSDjE0H34Kg+MtXbEkaKsr5hZOZpB3Kh/CYpXJSCKf3jMCNPB2TGGyIoSz1M6N79rHxaal1GwIAL2eUMy0/htK0eE3rHV7gKuPffpweQMoK2p5FZ2RbiVVIFQmAihuH2yI2DDfk5HgpWXL2mov2IxlKLIrPbeRMRsv5AIRt9UptBuT1uXuDcG8NVgubWj4Hb4ZezKUI/Sfh6Ci1j9NT9SznmJ414gy2T6vd6TmuuRiiiwBlgZ/rEpSiUv0ThoBHjpWdDUvz3jlWrmWPBX9e0riygBiuaaoBXFBiDUJtZStSc1iG+W2qCfxRMOzygjz40WPi7s52nT/uINdnBmoF4p4FFnl/hwwp4gOWDLQV/nsQbno6/FlmBNgfxDooOWBzz0tcXvQ96ANA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA62EFDB9EA7E0479DDCED52C7687833@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c47e17-c936-4e11-b730-08d85313c30e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 09:52:41.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOd8m8QsL8/P/12CX6EmTm0uCH7IoCItqVRoMMKlkrS9yD8VqiFAwWwFrITYu04iIZ5z9kCBlij4wOUBPiVKJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTA3IGF0IDA4OjQ5ICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIDA3LzA5LzIwMjAgMDU6MDYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiA+IE1h
eSBiZSB5b3UgbWVhbnQgc29tZXRoaW5nIGxpa2UgImxlYXZlIGEgem9uZSBub3QgYWN0aXZlIGFm
dGVyIGEgdHJ1bmNhdGUgd2hlbg0KPiA+IHRoZSB6b25lIGZpbGUgaXMgb3BlbiBmb3Igd3JpdGlu
ZyIgPw0KPiANCj4gTm8gSSBtZWFudCwgd2Ugc2hvdWxkbid0IGRlY3JlbWVudCB0aGUgJ3Nfb3Bl
bl96b25lcycgY291bnQgb24gdHJ1bmNhdGUgdG8gMA0KPiBvciBmdWxsLCB3aGVuIGEgem9uZSBp
cyBzdGlsbCBvcGVuZWQgZm9yIHdyaXRlLiBCZWNhdXNlIGlmIHdlIGRvLCBhbm90aGVyIHRocmVh
ZA0KPiBjb3VsZCBvcGVuIHRoZSBsYXN0IGF2YWlsYWJsZSBvcGVuIHpvbmUgYW5kIHRoZSBhcHBs
aWNhdGlvbiB3b24ndCBiZSBhYmxlIHRvIHdyaXRlDQo+IHRvIGEgcHJldmlvdXNseSBvcGVuZWQg
em9uZSwgaWYgdGhhdCBtYWtlcyBzZW5zZS4NCg0KSSB1bmRlcnN0b29kIHRoYXQsIGJ1dCB0aGUg
ImFjdGl2ZSB3cml0ZXJzIiBpcyBoYXJkIHRvDQpkZWNvZGUvdW5kZXJzdGFuZC4gU28gbWF5IGJl
IGp1c3QgcmVwbGFjZSB0aGF0IHdpdGggImFzIHRoZSBmaWxlIG1heQ0Kc3RpbGwgYmUgb3BlbiBm
b3Igd3JpdGluZywgZS5nLiB0aGUgdXNlciBjYWxsZWQgZnRydW5jYXRlKCkuIElmIHRoZQ0Kem9u
ZSBmaWxlIGlzIG5vdCBvcGVuIGFuZCBhIHByb2Nlc3MgZG9lcyBhIHRydW5jYXRlKCksIHRoZW4g
bm8gY2xvc2UNCm9wZXJhdGlvbiBpcyBuZWVkZWQuIiANCg0KDQotLSANCkRhbWllbiBMZSBNb2Fs
DQpXZXN0ZXJuIERpZ2l0YWwgUmVzZWFyY2gNCg==
