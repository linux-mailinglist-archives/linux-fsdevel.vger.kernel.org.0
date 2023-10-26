Return-Path: <linux-fsdevel+bounces-1245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EEB7D83D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32571C20F1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE12E401;
	Thu, 26 Oct 2023 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="jjZuoGDX";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="EtyUGEI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010A2DF96;
	Thu, 26 Oct 2023 13:46:43 +0000 (UTC)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAF196;
	Thu, 26 Oct 2023 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7557; q=dns/txt; s=iport;
  t=1698328000; x=1699537600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8g7KrFXL5eFIhlswnTvxvm0iC0/UzYRPzOkbnDfksy8=;
  b=jjZuoGDXpPbEwotpRrK7G9UBwxdVNAqT8E999dlSPP5FV6kf/mes5+oj
   cFOqj5p6qg0R5spAINdRAup5cmVNOBbNzV8gjh5yr1Wezv3L3YBU+ffow
   cpiZEJbuqamgZxKV9dDmfq1p++gOpVec/brXShtQoj2JoE67EQk4HIGaj
   Q=;
X-CSE-ConnectionGUID: oZ8QYIsSSceGGtSIbzXWwA==
X-CSE-MsgGUID: w+c8ZBfKQsaS5Ys+WyISPA==
X-IPAS-Result: =?us-ascii?q?A0CJAgCFbDplmIwNJK1aHgEBCxIMQCWBHwuBZyooeAJZK?=
 =?us-ascii?q?hJIiB4DhS2IYgOBE5FFiyWBJQNWDwEBAQ0BATETBAEBhQYChxgCJjQJDgECA?=
 =?us-ascii?q?gIBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNh?=
 =?us-ascii?q?kwBAQEBAxILChMGAQE3AQ8CAQgVAx4QMiUCBA4FCBqCXAGCXgMBonwBgUACi?=
 =?us-ascii?q?ih4gQEzgQGCCQEBBgQFSbIjCYFIiAoBigYnG4FJRIEVgTuBNzg+gmECgWCGQ?=
 =?us-ascii?q?4N1hToHMoIigy4pgRODZoclXiJHcBsDBwOBAxArBwQwGwcGCRYYFSUGUQQtJ?=
 =?us-ascii?q?AkTEj4EgWeBUQqBAz8PDhGCQx8CBzY2GUuCWwkVDDRNdhAqBBQXgRIEah8VH?=
 =?us-ascii?q?hIlERIXDQMIdh0CESM8AwUDBDQKFQ0LIQUUQwNEBkoLAwIaBQMDBIE2BQ0eA?=
 =?us-ascii?q?hAaBg0nAwMZTQIQFAMeHQMDBgMLMQMwgR4MWQNvHzYJPA8MHwI5DStAA0QdQ?=
 =?us-ascii?q?AN4PTUUG22eNoJPIC9MCQoBgTAUaxwSHJJJJzmCYwGMGKJhCoQMjAGVH0kDg?=
 =?us-ascii?q?2uTYZIYHpgellaMRoUMAgQCBAUCDgEBBoFjOoFbcBWDIglJGQ+OIBmBEwECg?=
 =?us-ascii?q?kmEUYFEiWR2OwIHCwEBAwmLSgEB?=
IronPort-PHdr: A9a23:HmVZ1xIgQqatXMSpQtmcuakyDhhOgF28FgcR7pxijKpBbeH/uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gL+H0EZPWht+f3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JJ/I7w4zAfIpHYAd+VNkGVvI1/S1xqp7car95kl+CNV088=
IronPort-Data: A9a23:CZWhfarLTTN2HIW7z83E1Nr/c5BeBmLPZRIvgKrLsJaIsI4StFCzt
 garIBmFbquNNmOjcttzaozj/EpT75/cy9EyHAc4rS4xQikUo+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7wdOCn9T8ljf3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYATNNwJcaDpOsPvb8k035ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86rIGaRpz6xE78FU7tJo56jGqE4aue60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/yxWZcV7FLH7zXeXtv7D9nznaEDXyPhBI10NHIcKytloKDQbn
 RAYAGhlghGrjuayxvewTfNhw5tlJ8jwN4RZsXZlpd3bJa95GtaYHeOTvpkBgG9YasNmRZ4yY
 +IQbDtkcRDJeDVEO0wcD9Q1m+LAanzXKmII8AjM//Jri4TV5BMy2+jfGtT2Q8eDfphkhQWnt
 0P9x02sV3n2M/TGmWbarRpAnNTnhz7gRMccE6f98v9snU272GMeElsVWEG9rP3/jVSxM/pbK
 koJ6m8gtqQ/6kGvZsfyUgf+o3OeuBMYHd1KHIUHBBqlw67Q5UOSAXIJC2EHY909v8hwTjsvv
 rOUoz/3LTtd4ISkaGmmzbyZghyuAgkfP189egZRGGPp/OLfiI00ixvOSPNqH6i0ksD5FFnML
 9ai8XhWa1I70JFj6kmrwbzUq2n3/smTHmbZ8i2SDzz7sl4lDGKwT9HwgWU3+8qsO2pworOpl
 XwAls72AAsmUszVzHblrAng4NiUCxutOTnYhxtkGIMssmvr8H+4docW6zZ7TKuIDirmUWGxC
 KMwkVoMjHO2AJdMRfQmC25WI590pZUM7fy/CpjpgiNmO/CdjjOv8iB0flK31GvwikUqmqxXE
 c7FIJb2UCZEVfQ4kGbeqwIhPVkDmHhWKYT7G8iT8vhb+eH2iIO9EO1cawLeMojVEovd/VuMm
 zqgCyd640wPDLKhCsUm2YUSNlsNZWMqHoz7rtc/SwJwClQOJY3VMNeImelJU9U8x8x9z76Ul
 lnjARUw4ASk2hX6xfCiNyoLhEXHB8gv9BrW/EUEYD6V5pTUSdz+vPhCKsVoLeJPGS4K5accc
 sTpsv6oW5xnYj/G4D8aK5L6qeRfmN6D3Gpi4wLNjOADQqNd
IronPort-HdrOrdr: A9a23:WqKfCKrFnVCDAEwsalFP2xsaV5tXLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6HwBEDhex/hHZ4c2/hpAV87NDOW9ldAX7sSnbcKpAeQWhEWl9Qtmp
 uIFpIOauEYYmIK8PoSjDPIdOrIheP3jpxA5t2uj0uFLzsaF52Ihj0RYm30YygGIDWuR6BJa6
 Z0jfA33wZIDE5nFPhTcUN1JNQryee78q7OUFotPTJiwg+Iij+j9b79FDal/jp2aVly6IZn21
 Lo1yji6Iuek9zT8HLhPmnogKh+qZ/E8J9uFcaMgs8aJnHHkQCzfrlsXLWEoXQcvPyvwExCqq
 iPnz4Qe+BIr1/BdGC8phXgnyP61iw11nPkwViExVP+vM3CQi4gAcYpv/MdTvKZ0TtlgDhP6t
 MM44urjesPMfoGplWk2zH8bWAsqqNzmwt4rQdctQ0EbWJUUs4jkWVWxjImLH5HJlO41Gjie9
 MeUP01I51tAA6nRmGcsW91zNO2WHMvWh+AX0gZo8SQlyNbhXZj0iIjtYYid1o7hdoAoqN/lq
 /5G7UtkKsLQt4dbKp7CutEScyrCnbVSRaJNG6JO1zoGKwOJnqI8vfMkfkIzfDvfIZNwIo5mZ
 zHXl8dvWkue1j2AcnL2JFQ6BjCTGi0QDyowMBD4JpyvKH6WdPQQGC+YUFrl9Hlr+QUA8XdVf
 r2MJVKA+X7JW+rAopN1x2WYegaFZDfarxihj8WYSP4niuQEPyeigXySoemGIbQ
X-Talos-CUID: 9a23:zy+6rm5eT8t/cApwP9ss83xEI/EEaUbmx3r/DFODKGx7eIKKYArF
X-Talos-MUID: 9a23:uoG/rglDegSJbDC5J0DMdnp9d8w40Y6gK3kWmK5bitLHCj1RAA+02WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 13:46:39 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 39QDkd1b025935
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Oct 2023 13:46:39 GMT
X-CSE-ConnectionGUID: xmZyDQmaQUWsqW/eVVoITw==
X-CSE-MsgGUID: bLzjuJ9ERZC9TNc4BeeC3g==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,253,1694736000"; 
   d="scan'208";a="6042802"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 13:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4IwjqlZVPZtmi0Q152RWMOBQeehjOAA7GstBrYCctPn3qAF7zx/aJ9y8mWwxSicPl3tPPXdfJcUynxHBOs/Yk6dXCZWyj/BpfGHEzXDrr6cuqnlw2SB6ZbcEhPHAWCVoUOgWFTTfaD/Pvst3rosSqzdKp/AKoMkE0ijLakqyKlqfs0SqoArv378C271JoF1SCiYjDwTdWECphV3l7gpECl6dh02OkXGHgV+vqnpvyucVv+xGpXhIwwo9ZNLZbxUbECUqfqvMQG9wriuAQ9qI4VSBrPuXgpTdUrKZ/dv0XF1lKwBoQAIat+Bp9HqoQleTiWu7imnEdQMPoeWSKsgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOss0gpoHnesWMjpvmNHauB0+X5/lDwCpykPfFA6bWs=;
 b=D4SqIZBG9CGhACco/F1F9qRzlCcySGFWPZXSQeBvggJ1cy5t5vtRriRt/6a8H0JCobMXXQcv2XFU4M9Kcwu3oA0o9nB3Q3yhSpShzUbPIU1dqmnHBnUd+LsMKYdiHVmxLy9zjj1WS05gU1jIWCxMWe7RHFs98w40BTwUd5PzF8wlYaDvQ90gYQMBSNrb2f+VgBNMye+b/yib9ODGWhJwi1ikvSCmHfPcctZ1npW+W7WOYe34FsFOeqlMLjXqbIzq9rSrq6TOySAhrqN2g0+ihHopFBs3PRz9TiSyQIsNEt6qfP1kE+GvAIz7r3RgFFflhKQNdi+jGxovRJJ7h28hYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOss0gpoHnesWMjpvmNHauB0+X5/lDwCpykPfFA6bWs=;
 b=EtyUGEI5YVV7hkU5zP2r/kfDP1A6K7yDnV6Gp9T00KICRlRRCvuiRFh/S73wY+8veMvkLdMaV5MgZtPNY0KpqrMNtBSqBm60eUsQOSJbbg4PLfW9M278sGj4sfFAu5DHsNjblRINI+/5SIG1AsbPsd/BmCbHIG3ednfmrEw8Sac=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 13:46:34 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b%5]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 13:46:34 +0000
From: "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet
	<kent.overstreet@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        Wedson
 Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 14/19] rust: fs: add per-superblock data
Thread-Topic: [RFC PATCH 14/19] rust: fs: add per-superblock data
Thread-Index: AQHaCBLVmLVn1a33nE+eLH8MrsXG/g==
Date: Thu, 26 Oct 2023 13:46:34 +0000
Message-ID: <prog6ftv632262xcjdealelqls4ktlduw3fhzpyzwvyu2ylfjw@pt7mmdk65epv>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-15-wedsonaf@gmail.com>
In-Reply-To: <20231018122518.128049-15-wedsonaf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|PH0PR11MB7447:EE_
x-ms-office365-filtering-correlation-id: 09dc69a2-227c-4f4e-e26d-08dbd629f7de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 25XLRawwpns0TiVdAMZJXxPtM8LBoIUjhDs1VyLH4su7quPWy6E3vdM3DmLv0lPyiKaM049wnh6k5b05Fit7piEgFFdsvofhZe2napK0QIxTjVMtn7vI0kPJmDMiEYP/c8kfJk8eOjQIUNze8Hvb8iu434eJ5W5DgWyQxYOsgT7A7LtKbJhzEJ9hsYdwN1M3qJtGODlXduBxJs5juGBBBtwUPlUHo1Sangu8WJzGTOR6YVXmJJscKbk9ylB706nfxeXZ094GY7oGE4CvAOKe/8WfKv7HTLUzONN2Z/iX7EYSiioRGLHG/+D7sctPl49r0ZswT/bcoXOTN2qPPN6rgPEpB2jLl6TvXW82LflQFzmAzKcxhCXTIP1wRA07OHhUOl/APGtIqwwMB/LcmsJaEAiRhwGKsLqG7xV+srxVAPET9k9zwrlsA/6JprQIMcxo8tWsrK2xCRuoCo+DDyGfFY9JopTT1eQuUudgVvC6NGx5733ykzd/ald1WlIbYTPP2erge4FZMU8zuYHeYQbEBWXTNPO7/dpX8rb5ydbhOYKNhplXCpBYU2gIX01i4vxBvpMBYGI8NatIUphT5J+GvIOhLPwjyis5nLDhCq8NkkymxPhEgWk7csJ2icJCDTyl3tVclP5sYnXDauWoMwMJvDqvl8qacSQ8ynm2/5RRmSM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(54906003)(66946007)(6916009)(66556008)(316002)(66446008)(66476007)(38100700002)(38070700009)(64756008)(86362001)(91956017)(122000001)(83380400001)(76116006)(6506007)(9686003)(71200400001)(26005)(41300700001)(8936002)(2906002)(6486002)(478600001)(5660300002)(33716001)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FS5OXZKl9TMfQF6ALZ8iOQnum9uoEbdgnNWeZpQoAT7cxQMMLgiHVTCKDkU8?=
 =?us-ascii?Q?PKovK0KaZf3RkE+sirKDK1apMgFPUHFyic0gBovlEBXtkqDR/QF3u4XToopT?=
 =?us-ascii?Q?AJVXqn445Mlc9JKGATi6QvuCQiPG7QBqvh8VBel+TTU6tY2xrcGDjDsK7jE/?=
 =?us-ascii?Q?ZjVs2ofU4wWz95lmpPDI63riisYnOb6K5vbWuyOyidGp1KVquZ4R8cDNKrlG?=
 =?us-ascii?Q?i9LNNM/DJUu65cgTmWiKvDkDgxlw+8MyvMpAVZEVFjPpxwi0O6dx7b+eqAGv?=
 =?us-ascii?Q?/dKoHNw8mjJv3f9f7EtS76Mxja88e28btM809gSNg0aXVpxY0X45nOTN2NPm?=
 =?us-ascii?Q?wcY/tkeyfcY2D+rhYH845SyC9JfDvKivhN/75IpjMLBSvdC+XMGMPmrbQY+0?=
 =?us-ascii?Q?btrZD/8PR7JNtoNs5llR+ShXYpkWOGginXxGPcIwwH2XjiPlBaJ5VDmD2Buc?=
 =?us-ascii?Q?YGugP32DEzFBUkGMuPXeAtjsSCUbVAvvX24OWI5VkujvEOc22pj0Z3wP3akY?=
 =?us-ascii?Q?895tvxfFw3XkyvlfmPfj2PDgvYDUKqYjfRn7lkifK/momfAl/tb1ZhoOtyX4?=
 =?us-ascii?Q?hy73ge6BrEOL+lKgw8Gzbz9/X2dYiI+c3TEkg9tfPhpp0zgS5vhMudenHgjl?=
 =?us-ascii?Q?h+wXGttWYSiLfO+k3vR2MNQBPZABdcC44h/2a12haOAXv3Q+diWqcTPSbUHT?=
 =?us-ascii?Q?rK2w9OO6cwPDIAkqbI4TzHB5xQhSzKWfgBeuRwvRLHapsUSi9epnR9CEF8Zf?=
 =?us-ascii?Q?hdzXJajEYEZKRmtL8NvrULyfiOmjSCdr9BbARG5J4qCRQQLbX1PpxizIkQ5I?=
 =?us-ascii?Q?alr0J1/X1/6iOaEtXS9crjVX0+pPrNGXtSMAFoqllgeYFfOKwUFO1dcfwhYX?=
 =?us-ascii?Q?1C6ibHGCYLLIz2CzUwHo+8xnMl0u21zahCPIU9kycUgBQaLXKagIEex5Ta5c?=
 =?us-ascii?Q?9RxxKsRflZ3YGpNMrWRQa/9YKGNqbxZ+6tc0vaAFCQXr8Zc6G3r8e+n6/G4n?=
 =?us-ascii?Q?DebrQZ2DF9dfNiRQED1W6wjl0jJgNlzYoKk+8/8PGc9Du+0RLTTRfwnAPmz2?=
 =?us-ascii?Q?1vAo8eYWupT6U8vTB3NyBlb7wx6GkZ0fjTPUjbLaYWwyONv8YXyFGEJwn+MH?=
 =?us-ascii?Q?aKlG5B7dodREutbsYE4/uZNRcZUZFoCZNqRtSrmikh9Z1J4IJtKztNXXn7wX?=
 =?us-ascii?Q?dKqQb9YwxDp/3FDck0YJmmPR/+crPh8W6vb1BcHGrri5b6c3Y0uF6GWCSSPH?=
 =?us-ascii?Q?qtOOo3dbZr1xSM36hvks/X86qi5HjAArBKd/H1lgdCT75UhWUh/8ddYxJ0yq?=
 =?us-ascii?Q?4Z9X+m/bW8NgyUTohMLJL2n1PcFooiY4q7wTOvOGWI92YTM2MouA/fT3SMA4?=
 =?us-ascii?Q?A/aGSr/4E5oO0sMTakx5Hp1s1GNZyGPtEwg7VJBKzrE9y1/FfpgNfCRE7S4b?=
 =?us-ascii?Q?UoxzOLxqzA5bAj6cCHWQ17P53tT/f1lDqwNlDDH8uURo11T9FL0tfrROTGfV?=
 =?us-ascii?Q?FQJBBWt6pm442YZKQlhWNKIG4sR0DmlbuoPXuOl1HYw01Sc7m3YMgbBLxxQ5?=
 =?us-ascii?Q?QPykdCdvbIa+7eLw2G8wqwebp2tSwMSZ+zCxQ1T3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A4D2B42E7A29E4181C495107617AE60@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dc69a2-227c-4f4e-e26d-08dbd629f7de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 13:46:34.3191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCEYZ+FhUllNpezWDpyotDVhbaiM4wzApKS1pX41Vx7UdH0aMOh0NXPvPM785BFC90lqIT6MbP/oTo4/U/eblA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-core-7.cisco.com

On 23/10/18 09:25AM, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Allow Rust file systems to associate [typed] data to super blocks when
> they're created. Since we only have a pointer-sized field in which to
> store the state, it must implement the `ForeignOwnable` trait.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/fs.rs         | 42 +++++++++++++++++++++++++++++++++------
>  samples/rust/rust_rofs.rs |  4 +++-
>  2 files changed, 39 insertions(+), 7 deletions(-)
>=20
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 5b7eaa16d254..e9a9362d2897 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -7,7 +7,7 @@
>  //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
> =20
>  use crate::error::{code::*, from_result, to_result, Error, Result};
> -use crate::types::{ARef, AlwaysRefCounted, Either, Opaque};
> +use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaqu=
e};
>  use crate::{
>      bindings, folio::LockedFolio, init::PinInit, str::CStr, time::Timesp=
ec, try_pin_init,
>      ThisModule,
> @@ -20,11 +20,14 @@
> =20
>  /// A file system type.
>  pub trait FileSystem {
> +    /// Data associated with each file system instance (super-block).
> +    type Data: ForeignOwnable + Send + Sync;
> +
>      /// The name of the file system type.
>      const NAME: &'static CStr;
> =20
>      /// Returns the parameters to initialise a super block.
> -    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams>;
> +    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self=
::Data>>;
> =20
>      /// Initialises and returns the root inode of the given superblock.
>      ///
> @@ -174,7 +177,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static T=
hisModule) -> impl PinInit<
>                  fs.owner =3D module.0;
>                  fs.name =3D T::NAME.as_char_ptr();
>                  fs.init_fs_context =3D Some(Self::init_fs_context_callba=
ck::<T>);
> -                fs.kill_sb =3D Some(Self::kill_sb_callback);
> +                fs.kill_sb =3D Some(Self::kill_sb_callback::<T>);
>                  fs.fs_flags =3D 0;
> =20
>                  // SAFETY: Pointers stored in `fs` are static so will li=
ve for as long as the
> @@ -195,10 +198,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static=
 ThisModule) -> impl PinInit<
>          })
>      }
> =20
> -    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_b=
lock) {
> +    unsafe extern "C" fn kill_sb_callback<T: FileSystem + ?Sized>(
> +        sb_ptr: *mut bindings::super_block,
> +    ) {
>          // SAFETY: In `get_tree_callback` we always call `get_tree_nodev=
`, so `kill_anon_super` is
>          // the appropriate function to call for cleanup.
>          unsafe { bindings::kill_anon_super(sb_ptr) };
> +
> +        // SAFETY: The C API contract guarantees that `sb_ptr` is valid =
for read.
> +        let ptr =3D unsafe { (*sb_ptr).s_fs_info };
> +        if !ptr.is_null() {
> +            // SAFETY: The only place where `s_fs_info` is assigned is `=
NewSuperBlock::init`, where
> +            // it's initialised with the result of an `into_foreign` cal=
l. We checked above that
> +            // `ptr` is non-null because it would be null if we never re=
ached the point where we
> +            // init the field.
> +            unsafe { T::Data::from_foreign(ptr) };
> +        }

I would also make `s_fs_info` NULL, as a lot of filesystems seem to do
(e.g. erofs). This would avoid any potential double frees and it's a
useful pattern in general (setting pointers to NULL after freeing
memory).
Maybe you could also mention that memory is actually freed at this point
because the newly converted Rust object is immediately dropped.

Cheers,
Ariel

>      }
>  }
> =20
> @@ -429,6 +444,14 @@ pub struct INodeParams {
>  pub struct SuperBlock<T: FileSystem + ?Sized>(Opaque<bindings::super_blo=
ck>, PhantomData<T>);
> =20
>  impl<T: FileSystem + ?Sized> SuperBlock<T> {
> +    /// Returns the data associated with the superblock.
> +    pub fn data(&self) -> <T::Data as ForeignOwnable>::Borrowed<'_> {
> +        // SAFETY: This method is only available after the `NeedsData` t=
ypestate, so `s_fs_info`
> +        // has been initialised initialised with the result of a call to=
 `T::into_foreign`.
> +        let ptr =3D unsafe { (*self.0.get()).s_fs_info };
> +        unsafe { T::Data::borrow(ptr) }
> +    }
> +
>      /// Tries to get an existing inode or create a new one if it doesn't=
 exist yet.
>      pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<IN=
ode<T>>, NewINode<T>>> {
>          // SAFETY: The only initialisation missing from the superblock i=
s the root, and this
> @@ -458,7 +481,7 @@ pub fn get_or_create_inode(&self, ino: Ino) -> Result=
<Either<ARef<INode<T>>, New
>  /// Required superblock parameters.
>  ///
>  /// This is returned by implementations of [`FileSystem::super_params`].
> -pub struct SuperParams {
> +pub struct SuperParams<T: ForeignOwnable + Send + Sync> {
>      /// The magic number of the superblock.
>      pub magic: u32,
> =20
> @@ -472,6 +495,9 @@ pub struct SuperParams {
> =20
>      /// Granularity of c/m/atime in ns (cannot be worse than a second).
>      pub time_gran: u32,
> +
> +    /// Data to be associated with the superblock.
> +    pub data: T,
>  }
> =20
>  /// A superblock that is still being initialised.
> @@ -522,6 +548,9 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>              sb.0.s_blocksize =3D 1 << sb.0.s_blocksize_bits;
>              sb.0.s_flags |=3D bindings::SB_RDONLY;
> =20
> +            // N.B.: Even on failure, `kill_sb` is called and frees the =
data.
> +            sb.0.s_fs_info =3D params.data.into_foreign().cast_mut();
> +
>              // SAFETY: The callback contract guarantees that `sb_ptr` is=
 a unique pointer to a
>              // newly-created (and initialised above) superblock.
>              let sb =3D unsafe { &mut *sb_ptr.cast() };
> @@ -934,8 +963,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>  ///
>  /// struct MyFs;
>  /// impl fs::FileSystem for MyFs {
> +///     type Data =3D ();
>  ///     const NAME: &'static CStr =3D c_str!("myfs");
> -///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams> =
{
> +///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams<S=
elf::Data>> {
>  ///         todo!()
>  ///     }
>  ///     fn init_root(_sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>=
> {
> diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
> index 95ce28efa1c3..093425650f26 100644
> --- a/samples/rust/rust_rofs.rs
> +++ b/samples/rust/rust_rofs.rs
> @@ -52,14 +52,16 @@ struct Entry {
> =20
>  struct RoFs;
>  impl fs::FileSystem for RoFs {
> +    type Data =3D ();
>      const NAME: &'static CStr =3D c_str!("rust-fs");
> =20
> -    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams> {
> +    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams<Sel=
f::Data>> {
>          Ok(SuperParams {
>              magic: 0x52555354,
>              blocksize_bits: 12,
>              maxbytes: fs::MAX_LFS_FILESIZE,
>              time_gran: 1,
> +            data: (),
>          })
>      }
> =20
> --=20
> 2.34.1
> =

