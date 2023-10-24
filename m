Return-Path: <linux-fsdevel+bounces-1097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DA7D54A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65FA1C20CC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893AD2B778;
	Tue, 24 Oct 2023 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="VL5TPbek";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="P+5zqLd4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492013FED;
	Tue, 24 Oct 2023 15:04:56 +0000 (UTC)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC7BA;
	Tue, 24 Oct 2023 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=634; q=dns/txt; s=iport;
  t=1698159895; x=1699369495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9qZVKPGTQ2svkWbqa+Pmg1lgqQJBh42fUsN1kLilYUM=;
  b=VL5TPbekFv2ZhnItUcy7acsb8X3gAoD743D7hdAeAWEV02wlBW5Rg110
   K9pGcEJfe8d9cZ4sM0QTcj2OeBUQwEvTYS1O5bJrNsYxBNNl7QYPfzm6k
   HSRoubNb8fe51TEqsFokeKe8WhrDI7KPigJ6SIZwkGQEUUgerH9Ip6grm
   c=;
X-CSE-ConnectionGUID: PJjQ/FrqR0KN2q1KGpTlww==
X-CSE-MsgGUID: 683Ct6paSrenj2xzg1PU+A==
X-IPAS-Result: =?us-ascii?q?A0AWAwCj2zdlmIoNJK1agQklgSqBZ1J4AlkqEkiIHgOFL?=
 =?us-ascii?q?YZAlHyLJYElA1YPAQEBDQEBLgsLBAEBhQYChxgCJjQJDgECAgIBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNhk0CAQMBESgGA?=
 =?us-ascii?q?QE3AQ8CAQgOKBAoCiUCBA4NGoJcAYJeAwEQpRQBgUACiih4gTSBAYIJAQEGB?=
 =?us-ascii?q?AWBTkGwXQMGgUiICgGKBicbgUlEhD8+gmECgWCGQ4N3hTwHMoIigy4pi3ZeI?=
 =?us-ascii?q?kdwGwMHA4EDECsHBC0bBwYJFhgVJQZRBC0kCRMSPgSBZ4FRCoEGPw8OEYJDI?=
 =?us-ascii?q?gIHNjYZS4JbCRUMNE12ECoEFBeBEgRqHxUeEiUREhcNAwh2HQIRIzwDBQMEN?=
 =?us-ascii?q?AoVDQshBRRDA0cGSgsDAhoFAwMEgTYFDR4CEBoGDSkDAxlNAhAUAx4dAwMGA?=
 =?us-ascii?q?wsxAzCBHgxZA28fNgk8CwQMHwI5DRgDRB1AA3g9NRQbbZ0mbIQkgWpJCpYdA?=
 =?us-ascii?q?a56CoQMjAGNG4gESQODWKYJmDyNZZpDAgQCBAUCDgEBBoFjOoFbcBWDIlIZD?=
 =?us-ascii?q?445g1+CZIIwimV2OwIHCwEBAwmLSgEB?=
IronPort-PHdr: A9a23:j87iORXZ1+djporyCl1XUBSIRg/V8K0yAWYlg6HPw5pHdqClupP6M
 1OavLNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2s2y1uuv/5TISw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Qv3JScuJKxGVlbV6ShEP64cG9vdZvpi9RoPkmscVHVM3H
IronPort-Data: A9a23:jScAu6neakOpnkSt6edTijPo5gxXJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIaDWyPOPmON2T9LY8nYYnj/U0F68LRzd9hSwM/pCkzH1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4E/rav649SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+5a31GONgWYuaTtMsf7b8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSq
 zHrlezREsvxpn/BO/v9+lrJWhRiro36YWBivkFrt52K2XCukMCdPpETb5LwYW8P49mAcksYJ
 N9l7fRcQi9xVkHAdXh0vxRwS0lD0aN6FLDvGVq9iIu91VT8K1jKmew3L24uAYkH5bMiaY1O3
 aRwxDElZxSHgae9x6i2D7QqjcU4J86tN4Qa0p1i5WiGVrB9H9aaGOOTvo8wMDQY3qiiGd7XY
 ssSdD5mdzzLYgZEPREcD5dWcOKA3ymjLWIB9w3KzUYxyzaDlydtjqDkC8DYfN7QVddax36l5
 UuTqgwVBTlDZIDAllJp6EmEnPLUgWb1X5hXELy+6+5CnlKe3CoQBQcQWF/9puO24ma6WtRCO
 wka4SYjs6U23FKkQ8O7XBCipnOA+BkGVLJt//YS4QWJzO/f5ByUQzVCRT9aY9tgv8gzLdA36
 rOXt+vLBwUonqeMcyq+0O2N9BCdIRQRMnBXMEfoUjA5y9XkpYgyiDfGQdBiDLO5g7XJ9dfYn
 mDiQM8W2uV7sCIb60mo1Quc2m7x//AlWiZwt1qPADP0hu9sTNP9D7FE/2Q3+hqpwGyxYlSHo
 H8C8yR1xL9QV8jV/MBhrRlkIV1Ez/+BNDuZill1Etx8sT+s4HWkO4tX5VmSxXuF0O5aIlcFg
 2eK5Gu9AaO/2lP2NMebhKrqWqwXIVDIT4iNaxwtRoMmjmJNXAGG5jpyQkWbwnrglkMh+YlmZ
 8bLKZbxXSpKVvU+pNZTewv7+eFzrszZ7T2LLa0XMzz8uVZjTCfPEOxcYAfmgh4Rtfja/205D
 Oqzx+PTm0kAD4USkwHc8JUYKhgRPGMnCJXtw/G7hcbdSjeK7FoJUqeLqZt4ItQNt/0Myo/go
 CrnMmcGkwWXuJEyAVjQApyVQOmxDc8XQLNSFXFEAGtELFB5Pd71vfxDLMNvFVTlncQ6pcNJo
 zA+U5zoKtxESy/M/HIWapyVkWCoXE7Dad6mV8Z9XAUCQg==
IronPort-HdrOrdr: A9a23:itS5faCSx0SFTxLlHejQsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdhZJhBo7y90KnpewKkyXbsibNhc4tKLzOWyFdAS7sSrLcKogeQVBEWk9Qtt5
 uIHJIOdeEYYWIK6voSpTPIberIo+P3sJxA592us0uFJDsCA8oPnmIJbjpzUHcGOzWubqBJbK
 Z0k/A33QZIDk5nFfhTaEN1OdTrlpngrr6jSxgAABIs9QmJih2VyJOSKXKl9yZbeQlihZM5/0
 b4syGR3MieWveApSP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CClCpdmpDs1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6jh2f5q8CRfkN+NyMBv/McTvLq0TtngDhO6t
 MT44tfjesOMfr0plW72zEPbWAwqqP7mwt5rQdZtQ0tbWJXUs4ikWVYxjIXLH/FdxiKtLzO14
 JVfZzhzecTflWAY3/DuG5zhNSqQ3QoBx+DBlMPo8qPzlFt7TpEJmYjtYQid007hdkAYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiTcg8Sj7wgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3f071E8WB0JBC7xiISmSgWjbmzN1Y+vFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTGPPnJXuGI/cB4+Q/YeglFZAzarxjhj9gYSP6niviEPyfitDm
X-Talos-CUID: =?us-ascii?q?9a23=3A+hl7PWuJWx0xua+FnLll6ngK6IsdUH/ki1nKOnX?=
 =?us-ascii?q?gKkAzUeS2Zkes/Lx7xp8=3D?=
X-Talos-MUID: 9a23:LwdPawsS9oGqu2qW5s2n2mE5H9s2+62VEk0Lk88WqcbdDREzEmLI
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 15:04:54 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 39OF4mlj012662
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Oct 2023 15:04:53 GMT
X-CSE-ConnectionGUID: QQW2pFpqRE+8wJTvzxvSAg==
X-CSE-MsgGUID: 3E5uxDMZTNytOQovFdz1nA==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,248,1694736000"; 
   d="scan'208";a="5658987"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 15:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIx3W9hD48QJtP9i503YgIK/Fc+hokL7SGwiMCn9q1rZadh1BAQO5fKs/QX9thl0UkAv92/b2tSdp7RIVP44ILamPOScDRvuin53v9iw7AxJBX2U2gxFs5voV9axxecrSaYE/Yrn+o8wANtXA0OVEzGj6Lf+PIWK1yrkx2NmjisnA8XbAeuUzDo07cBWvip+1FJ44llR+dVwZTAI5NQLOAM8bDdam4/s2dt3i71FeNUKOsNfNIEpsmL0kwAmiT0b3x8lSBitFy/jZMY0EcYwjWFXzJ4s7+8OcMYFfb8tLAOZEu3kUuvzMd9IvpouMlIf/MI3D0d2tyOhYm9ylP2Srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qZVKPGTQ2svkWbqa+Pmg1lgqQJBh42fUsN1kLilYUM=;
 b=CVIY05rZ8cdVA9L6EDcRTtXPMEMZrpsfL1RidI7vnHyphQgfpvYosMqzdYsLZhRTZIjiWSsa3qZTHUknkMoCBd0juBlUkQbv8fFOcZLD7D3Ny/T6t89lLFFgVoN1jBa2SlArNC3k71fWRvb3m2kBhYDnxzaTFj+OtElxtR/oQhDmBvkYx9paD93TZ4hXjhp/xptRCkbOsFRHr++KaECZjslWiN661h+R0RYR3i8uIjjnsV4S2coc/6mOtYaaF6FEjuic5Av33mvzNt+NpnSl2VauAR2U+7ST8HQK0wsTkov9lBAvwM7Bp949+hCw6B4ht3bdtfPcKZBr/nHjQ+k6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qZVKPGTQ2svkWbqa+Pmg1lgqQJBh42fUsN1kLilYUM=;
 b=P+5zqLd4Isk8s1u5HfYMEyrJO+Pmme+ag0Y+Ltm7iLMErEIlEk8AC8B30znf80oKGbb2MS+Ushull8Zqre4YfUaQsyXu3lQA1woIBfcTOeuDMq0wwJf3LSJY/B5zKMM3IbFeuZjWD2mP/cGHyEusw23VITUy4wnS97+/WcUj84M=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 15:04:44 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b%5]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 15:04:44 +0000
From: "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
        Wedson Almeida Filho
	<wedsonaf@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian
 Brauner <brauner@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        Wedson
 Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
Thread-Topic: [RFC PATCH 09/19] rust: folio: introduce basic support for
 folios
Thread-Index: AQHaBotrwmJzSTXa6E+x3/+iFAkeAw==
Date: Tue, 24 Oct 2023 15:04:44 +0000
Message-ID: <7pnglle4glh64ibucauqidizp6ewcqkzvzrgpnsuzpbcvxzvdm@3yypkguthvdz>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org>
 <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
 <ZTAwLGi4sCup+B1r@casper.infradead.org>
 <CANeycqrp_s20pCO_OJXHpqN5tZ_Uq5icTupWiVeLf69JOFj4cA@mail.gmail.com>
 <ZTH9+sF+NPyRjyRN@casper.infradead.org> <87h6mhfwbm.fsf@metaspace.dk>
 <ZTaDFe/s2wvyI9u2@casper.infradead.org>
In-Reply-To: <ZTaDFe/s2wvyI9u2@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|SJ0PR11MB8296:EE_
x-ms-office365-filtering-correlation-id: 9e75f101-dc28-4524-35e9-08dbd4a28e78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oQDS5Jt1YmxrDwvfG+LcJkTmNCsmGHsXePGprWEsnOEqybOJq6Dz9hCm2I8pwrRSgkRhoijjJMsNrH6XfyzP0xtJeGZPsCoJbuYw/hw/Vffl7kPSrhq9vVvD4rMn/8b5XWfX5w0WuLKnew1SbSL3ukVYvnYO+4KwnoT8+JcILoo1OIoX5V9OHLWMDU4xhiOgiIIUkZQiGZmVkrVNdls9mNLw5rUFoYUTxAggx8aTp7kbuFDXhCggVsDGCvE3vf1z+Qe1GJrKHhHwVAyYJG0iPQij94GjU8fQuqNrjeTl9eNcB7232AE/B0bKLmTwLzBtk6fpM0jIyvf2UGt1OuJSv11blZUwbi+xjkDC4ImqAtDxChraRodBx3AnsaYlPd0M8wX+zgUi0TRLeQKiEMs0kVQieeYV0ZCeozGN+GdXWyNO8JFmAnhzaY6fkACJtg2S7Kp/lULkSImZHCXr/TxKuAWGgR50nmR233JJa/GlCQAOZwOV7/hrMKXdsgvI5aePV3R5GnvOXFmftJkpMUHob5t2uiWFoFRUizbxdDQg09j4o5NmE07RwlIe/CGsPJWe9PdtNgOWaPufbwg7+Ifo3JGqHymsJ5Rm3ZrQNEdrPvc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38070700009)(86362001)(4326008)(2906002)(38100700002)(54906003)(478600001)(966005)(66946007)(76116006)(66446008)(66476007)(8676002)(91956017)(64756008)(316002)(6916009)(8936002)(66556008)(71200400001)(6486002)(4744005)(6506007)(5660300002)(122000001)(41300700001)(26005)(9686003)(6512007)(7416002)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KyCnEJQbhYWAjSLp/I2Lwi+JQuevcnL8N8JcCK9mjxJ6sZZpCU68srmWgSWE?=
 =?us-ascii?Q?VZqJ6g5HKwobYHb8sjdzfM+i7d6UVlwm58og1ygbZs3kR4aZiUp2KerezvDR?=
 =?us-ascii?Q?OmSrr0Om48pYT1e3X6rTR1plFzAyEQyK0iNXIs1h4svKVa4CfwCjBvIHSkHu?=
 =?us-ascii?Q?h0+np9zCUyyUyGUfUdyfDd+7tKkdXET1U2HhL0wIwYKmqwTRubud4Wl2afQf?=
 =?us-ascii?Q?tq2I82Yhrs7u3WbRaltLnnuWZy2eadgNsGUIeoElFqqTeu4BaVbLTE4/iDyN?=
 =?us-ascii?Q?DWQCwwROb9RTjKWkd+3ONNjgwqdadrM+y55IiymFm2XUExmJPJtVJDnTDH5y?=
 =?us-ascii?Q?5KpeJmqJjYUMtK1zwiN1UlNp5CirU16s5z9XevTt1qIfmmIy7se2hVupFkJ+?=
 =?us-ascii?Q?L75M6Z/P56DvS9UJE40FeaE+EIKUB5B4V0jme37EZ9x1DhzBQm+Lj3o/KU/6?=
 =?us-ascii?Q?LVT4zqGCWzTJiSPUc2BeSX/Aew60Z86qq8V5RoMNeZs+sFJr899lIo1Blta+?=
 =?us-ascii?Q?88y76uWGlY0sBpjWS+CVBze5tsxUR+nLHv6Nit9IXIodSmdGmJ8a9BtquJ9B?=
 =?us-ascii?Q?ZSfdTX5sgN/PdZFnMvzh9MUSF2yoQH5xuqdM4RTMX0Gj1rkpF+C/B+9KJD+X?=
 =?us-ascii?Q?fIhuxn7aetD8r8u1+6C1ydCcxJMKxegqPr0686tsPN2IwmraVmGbHHzDaTMu?=
 =?us-ascii?Q?BdlND8GySpLyA8ntD6DqJnscjlFh3TxobOhzvC39/twIrbLKpIQo1bikngHp?=
 =?us-ascii?Q?wK9j0SpxvQ+e6HBOXvu8+mrRxrRIgtnINrnXSV9xw94C9iUJgDvm6eQ9s0Yf?=
 =?us-ascii?Q?G5QJcMu5J0rcfDdtSrBAOQX9v2yMmETSVUCXtOxyqK94RwksUdV/ZdYa3fRG?=
 =?us-ascii?Q?SW+9efGGfV1LvwQaw9wiwz2Wxmc7v8O/drX42RWRK5zbM+05US4a/hunlU+U?=
 =?us-ascii?Q?sJC61BlkybVPwvGnDijsVS/7tZuXENX1e+qITY+PZOGRpx0FOz11oprNFquT?=
 =?us-ascii?Q?KsHR+1e413yezSDqmQJoZUq2vCy8dlb5bNxB7SUG1KuyCLX7wF/NM3gIc3mD?=
 =?us-ascii?Q?FAd+RF90+kzvNe2yyhN3eik3v+TM5yxrp7kFFkBYu1BovHaKcRnYaiv66KPW?=
 =?us-ascii?Q?0m1XFf8lMEPGsJ/eRHF30JfXKhjXHQTK9R0kJ7lo5OEwWqBUVdzdMEMWevDW?=
 =?us-ascii?Q?1+Bpyxkf3h+5PHRoiBy6W5J8Opi2qentaT+Z+bEC0Dx0yITosk9WmJhRVhwu?=
 =?us-ascii?Q?u1/3D17h5mJGgvbmhCRC6gY8uQ1qzK9ibgHdheOOSk0OUr7q74jC+C6EZJPu?=
 =?us-ascii?Q?yoO1xXv0oNWSVCeez5RMMkanpp7QsCB6me0X+cWgywpwzsv4q1g3iI4lRalx?=
 =?us-ascii?Q?FpgM/P1buyQDQOl/QGF91xR6B2Uqy/Ggcyl0MU2XGweKwmyXjyxtSOyZQVVN?=
 =?us-ascii?Q?ehhjlZ3PaVStMfmz2FjQPyMCn30qtUFEWJZE6KnARUHWezbqvptUzwg9n//+?=
 =?us-ascii?Q?LRWtv0tTmodXvJO6rbkF0YsccKA5LvLwv+CqjGhmFlMZXzfeEza5LYIMVCzT?=
 =?us-ascii?Q?1OhXSffzQXMZhO1SkQUH56+wDbhfFHZNX2Rx/mLa?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DF76DE983B64F4886ED69EDB9BCAC69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e75f101-dc28-4524-35e9-08dbd4a28e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 15:04:44.3012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SvnAMT0hU0WP1OletVVM0lNTgk5DxyDwfXfwmp5cOf4fp4cEVa1Wla+P3ySWhTtLKUVYdrwRwyYumUWAxIAHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-5.cisco.com

On 23/10/23 03:28PM, Matthew Wilcox wrote:
(snip)
> I'm all the way up to Chapter 5: References in the Blandy book now!
> I expect to understand the patches you're sending any week now ;-)

That book (Programming Rust) has some great explanations, I went through
the first 7 chapters after reading "The Rust Programming Language" [1].
If you also want to dive into unsafe Rust, I recommend "Learn Rust With
Entirely Too Many Linked Lists" [2], it covers quite a few complex
concepts and it's very well written.

[1] https://doc.rust-lang.org/book/
[2] https://rust-unofficial.github.io/too-many-lists/

Cheers,
Ariel=

