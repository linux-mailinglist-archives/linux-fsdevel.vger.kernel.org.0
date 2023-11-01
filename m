Return-Path: <linux-fsdevel+bounces-1768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4977DE772
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 22:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6264628170E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FEF1A26B;
	Wed,  1 Nov 2023 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="KtmvMBCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2418630
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 21:35:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAFD115;
	Wed,  1 Nov 2023 14:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgVF/Pny8mDHmfh5dfuXawPhj7Yp0YdcJXHIEmr4Ow8yI5v3+mD5ViV4poMGCgUIhbsVuMLojgZFWPo2i6jVLQdLlJaNolLewb2ZpL2XvlETR99XcRbCc1d1pCAUtR7WKlsCN6npLpGmqneIZqtk90iA7qoZ0KaEL6GCOCJYPXtsYUps6V5Zif+G+mmEZmh6LFF541U0f2DB76A/Cs/FQ/lElhnKphenmA5Au7mHz9UU8vNVFAbuJ4HWrVitWTyCev5Q6o7rokH4CEBIQQC5vSelOJ3MShTseHB4+yoIXqK6JFMujgimZrRsiTjxMIyakwvJsw5DL0cK9Hql3SwIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0lC5Gmlxwsed8NvQu2rwuQD0Y3WGuMeopGQ472bqbs=;
 b=HDaifPET1Q9sTV05TNjI8sPriI0VFjHoYYiwYGbgw9MuKJFbZ9t5NJrQp0+rTg2pCcyYYYdYz/hcJIRVCo3aebc17kHW6/ARNrOMqMlr5PycU8zoJsPl7Wv+oIDdXDhUNa12pNte98hm7PWIFDTmU3YiK7413me+ugSm+5+bbrcacDfLO7/jSpsPDbOwdVBriErbW5KYozw+tbo3BdToJNI0tOIpNhAXC/Q4mZkPLbbkN4nvT9blMoU6LiuJEtoTmvNKNcWOfn5YvHjD3J0F3LUPJhCerJ4Po6WgZXgm2xFdclZwdrIv9IabaNjFpVhu6Ng9jsT/fea/m2Sx5dv00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0lC5Gmlxwsed8NvQu2rwuQD0Y3WGuMeopGQ472bqbs=;
 b=KtmvMBCFbwdYkKiDJZMmZCiBUla7jUplEav69XEvStHt/PLto+HxTVW/U58kQ9N71L/7cA9s4nkYwpsFVxh+t+vzLom4K7jfgdN01SPKKXPwHiv4gIMjtoqOVVL5MIZzjPMW3XAfwZB9Zluf/x2u6hCXAdXE67cG696QkHBo5ho=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 CH2PR13MB3685.namprd13.prod.outlook.com (2603:10b6:610:9d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Wed, 1 Nov 2023 21:34:57 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::50ca:9941:2396:90f0%4]) with mapi id 15.20.6907.030; Wed, 1 Nov 2023
 21:34:57 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"jack@suse.cz" <jack@suse.cz>
CC: "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"jstultz@google.com" <jstultz@google.com>, "djwong@kernel.org"
	<djwong@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"chandan.babu@oracle.com" <chandan.babu@oracle.com>, "hughd@google.com"
	<hughd@google.com>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"david@fromorbit.com" <david@fromorbit.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "dsterba@suse.com" <dsterba@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "tytso@mit.edu"
	<tytso@mit.edu>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "jack@suse.de" <jack@suse.de>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Thread-Topic: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Thread-Index:
 AQHaAepiwRK5xtu1cEOlqP7L4UYm0LBP6+MAgAAY74CAAAwxgIAABgCAgADCl4CAACFrAIAAsQcAgADtloCAA82AgIABFCGAgACRmICAAA52AIAAOIwAgAA6FACAAME+AIAA4QCAgABIsYCAAOlogIACHKEAgAWAfwCAAAm3AIAAKhyAgABZxYCAAEojAIAAr2uAgADOqACAAKXBgIAAF7UA
Date: Wed, 1 Nov 2023 21:34:57 +0000
Message-ID: <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
	 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
	 <ZTnNCytHLGoJY9ds@dread.disaster.area>
	 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
	 <ZUAwFkAizH1PrIZp@dread.disaster.area>
	 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
	 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
	 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
	 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
	 <ZUF4NTxQXpkJADxf@dread.disaster.area>
	 <20231101101648.zjloqo5su6bbxzff@quack3>
	 <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
In-Reply-To:
 <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|CH2PR13MB3685:EE_
x-ms-office365-filtering-correlation-id: e51a494d-bc0f-4fbb-bbae-08dbdb2264fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 I1/bV5vKlJ9/TvhDwDnJ9SP26Lh0wstAF+9bh0a/QTvkSEQknuuF6h7Jv4HImtUnIe2HH5KkAHXhYmfR3qbAq6ZCxoE6auVUebSDd49R63A9CTo+1m26VzRBiy1C2T6dEyGxyeMPNu71hiuQkLBlD99nVUgqu+XZHnypBdUQhvLcXP4IqB1/YXrR6k8b1RIc5d/GznfdRopm+G3lauU8LF0H+xwxx/VwtHyxa9zs88XbBLupQMoiD2YDX9AiDvN9iVcZ+SSYLsBeS0Fn+h59hj1MdauZO82YhfHn77EYtssmg30pBwGdqeoWStRPWaTMfYjd2aQi2JIlwATEyK/dH04pbky5yDecpwycIs07rrDxZrA6kPtFL4lHlNioHgziFj6FutdsmSM7lxIr6aL8V8/37RTE5/JM4xMS+9T1ALb4lMNd3n5PoFP7F7VpiSAjbAHWnsIKcjnRxCQqCoG85ckjVWAef5ykP3r+1E45IeATELpsnpgCJcx954q0Z95OQNe8gRqTGfuBURM7XkecpP2reba4f9dwXh+UWDeasvc9uq2Hls7nAMZ7Go2dLyovOrSgCSnB4JrNeSOp9OpSrZ1Fgk1rGaC8fKIH6jPRXE4ORpnYGKahjolG6q1ueZ7hy/nBz0XzM+wzm2RByBj+IJc+8+QPb2sdP4IgLz01kmQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39840400004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(110136005)(91956017)(2616005)(5660300002)(2906002)(316002)(83380400001)(41300700001)(38100700002)(478600001)(8676002)(4326008)(6486002)(8936002)(71200400001)(7416002)(122000001)(76116006)(66476007)(54906003)(66446008)(66556008)(64756008)(66946007)(86362001)(6506007)(6512007)(36756003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2JMOUZxTXVDQ1ZwT2tsU2hJMFkwV1kxa1VRM0lxTDZXeWR5dUVRSDBnYi9V?=
 =?utf-8?B?dG95NktvcWVSNFJwaENHYzQxKzNhQUJDeEZURzZQZ0U4U1FvbjA3VTNham9I?=
 =?utf-8?B?U2RRMjRGL29NR3IxZStMMndEQWtFNXVEajhlM2JzMllhUDR0T3hHS0I1bk5M?=
 =?utf-8?B?eHA5NzFhMTFCK1hubmFCQ3JIZklmSjU0cjdmbWhOdys2OTdhWjduSlhLVHJ6?=
 =?utf-8?B?cUFXanV3SUw2U2RnS2tPOERaNHZmdll4UDFzbFVWZEpUSnBKVURzR1NuVDlH?=
 =?utf-8?B?RlIzZGFBeTdwaE9zNjVaVWtqZlptRVBDdHR6a0t4bGVaTVFLc0R6NVVVd29K?=
 =?utf-8?B?QlhOU0Y2TXRsckFvZzY3c3FncVYwNTZ5RXdIdGowRXlzSTNTSEl2SS9Rc3RW?=
 =?utf-8?B?T1JaZ2lRbkp2cC9aTExOaWlwbU1BRjlxSytJdE9CTHc2RHRRaHhHRkNhMnZq?=
 =?utf-8?B?VlhmR3ZHUk1zSkQ2QzF4NmNtTmtnaFNZaEhLc2VUTGdYSEVSQXVmTG4wQ1hY?=
 =?utf-8?B?bTlFTTAzVWlLNGJnU0tDandsYktsdloyaDFxd09ZZEhTaWhiSU55WjBKd1d5?=
 =?utf-8?B?ZU03RHhUYlM0ZDNHN3I3aGpST1hXTGlVOVZMN0NlSDBNa3kxckpsWnAvUEFp?=
 =?utf-8?B?U0trVVlwNy90Vi92Z1Naekp1QlJqdWxLNzZ4cUNnSmN6eFVTMFBsL1lrbm1i?=
 =?utf-8?B?eEdFUnJHM0ZkS2ZPREt0OVlvSFIrNk1yRzJHZ2pUYy9xZm90N0Z5N21UNkFU?=
 =?utf-8?B?T1ljdm9qK21QanVhWk9WbHZSbkxmUXNlVWkrUGZVTy9xbnFhNnhvb3cwenVY?=
 =?utf-8?B?VXdmVFc0M0RmWTUxaDJ2MmY0WEtXcCs2MWV0ZG1EbWUyNzVVNUEwUUd2YmVy?=
 =?utf-8?B?RDJObU5ORVd6TEJ0N255WWI5dWNDeDF2WEZHT1B2UnZMUE9kelJGaEUxWUdS?=
 =?utf-8?B?OUFZVHRFZ00yakZaSmlaU0pVRzMycTJzTU1HNzBuNVZlZnUwUjJxM3J6NXgz?=
 =?utf-8?B?c2tiWXFqY0o5TDJpeC81UGthVlN5cXU3UXl0aWtYL2szWmhMdCs1QWwwdGZo?=
 =?utf-8?B?VWFqeTUrYUY2U0ZqZmNKNjRPTUJ5K3l1SlBtNFhacjZ2VjNpZEg2U1ZqaEk2?=
 =?utf-8?B?L3pzYkt5Rm0vUFlweWlVWFVLWWFCSUFZY1ZoTy93NE9aS3R3UmNxS1hlc3Fw?=
 =?utf-8?B?aU16ejBGT1ZIWmZ2dzNPT0V6WFlJQlhCK1ZmMWZwbTZWNGNHNmhjVzlCS1VH?=
 =?utf-8?B?TjlVbkRsVG1BYjNxbzRvVUVRYUgxTkpCNXhDenkvNEp6a0QxTlQzSTNORjVo?=
 =?utf-8?B?Y1NKcjFNbHhUWGxiWjNqN3VER1hYQk43RlEzQzBjSFB0MTJ2Z0hKbmZ0cEZN?=
 =?utf-8?B?ajZjVGdpVytjRDVlRVFIdzQweHZRWGhwcG9IdWlhYWY4SmM0RFZjWHFUb25p?=
 =?utf-8?B?b3FVTCs3YXlQa0xZUCt4MDFWOGRRbC9FQW9KcWo0ZUtiK3Z4bkNSaFJhcFM2?=
 =?utf-8?B?SkdoRDJTTnA3Zks3cXhCdEVCMFV0Z3FzREJlaEVWaTYvSFQyVC9WZG9Vbngw?=
 =?utf-8?B?elJzNjdYSFZiQzkzaUVCNTNTanhXdDlCWlNveE5YajlOenBqdThENFVKZnlr?=
 =?utf-8?B?dWZyTUg1clg4QmJsWGhtdjVibzRkV2x3dG1HVmUvdWtkYWJhaXU1YWhvQzdu?=
 =?utf-8?B?U2czRG9aNjBqTGZuT0tEYzd6RFNkTmtKTkRxZlVJc2JMcHBmV01jYXJxT2hw?=
 =?utf-8?B?MEc1VGl1eFdTd1lhL3plbyt1Q1Y1VE9hTEd5WTFrRnFUQmcvaVl6Z2JNbzZv?=
 =?utf-8?B?c29BTzdvSDFNRjRjTWdFdzJwQk9sUnhqRnRpVEdCQS9tZTR4T1pNeHRDcFdw?=
 =?utf-8?B?R1I3OXJvbWZCRzFBczRFcEdXaGFUcVVxMm41eTBXSEZScVpyR3VocDgwNXlI?=
 =?utf-8?B?bm5sMmhCR2NvMWN0Qk5nQnUwR2ppajBCaXJnRndPOU1Xdm9VanVvVkFyTUFm?=
 =?utf-8?B?R1p4VEk3SEhRd21aZ2l2Y2EzMWNoU09pZysxZkEyeWVvZW9QNkZBWVlBNmZV?=
 =?utf-8?B?RnFZUzVPR3h3UGRHdiszR1Q1V3B3LzBFcGpSU2ZLU2FrU3VRUjVqVm5Qbmxi?=
 =?utf-8?B?bCsvR3ZzZ3Nrd3hIT1BQNWhXOTVqWk4zOGtZYXJjY0RGZjdpK3RWN1NWZEtK?=
 =?utf-8?B?QzF3allQYkUrSDg5OXdoZDhBMEd6VXFMZ3lZN2ZNS2kwWStMVVVKZW0yeGVx?=
 =?utf-8?B?V0tmV2Rld2VUeXZKVGxQSXowR2tBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <011B710EAF53E643AE533D67F86AC4C0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51a494d-bc0f-4fbb-bbae-08dbdb2264fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 21:34:57.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laKaXKPdikqRpLbx+DdIn+/0Pf1/LUWKkRmRteaLp3O3sct5SK3vjzlpqV5fqLEIp2ZK8vfySzgf/XRGpH2cow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3685

T24gV2VkLCAyMDIzLTExLTAxIGF0IDEwOjEwIC0xMDAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gV2VkLCAxIE5vdiAyMDIzIGF0IDAwOjE2LCBKYW4gS2FyYSA8amFja0BzdXNlLmN6PiB3
cm90ZToNCj4gPiANCj4gPiBPSywgYnV0IGlzIHRoaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBjdXJy
ZW50IFhGUyBiZWhhdmlvcj8gQUZBSUNTDQo+ID4gY3VycmVudGx5DQo+ID4gWEZTIHNldHMgc2It
PnNfdGltZV9ncmFuIHRvIDEgc28gdGltZXN0YW1wcyBjdXJyZW50bHkgc3RvcmVkIG9uDQo+ID4g
ZGlzayB3aWxsDQo+ID4gaGF2ZSBzb21lIG1vc3RseSByYW5kb20gZ2FyYmFnZSBpbiBsb3cgYml0
cyBvZiB0aGUgY3RpbWUuDQo+IA0KPiBJIHJlYWxseSAqcmVhbGx5KiBkb24ndCB0aGluayB3ZSBj
YW4gdXNlIGN0aW1lIGFzIGEgImlfdmVyc2lvbiINCj4gcmVwbGFjZW1lbnQuIFRoZSB3aG9sZSBm
aW5lLWdyYW51bGFyaXR5IHBhdGNoZXMgd2VyZSB3ZWxsLQ0KPiBpbnRlbnRpb25lZCwNCj4gYnV0
IEkgZG8gdGhpbmsgdGhleSB3ZXJlIGJyb2tlbi4NCj4gDQo+IE5vdGUgdGhhdCB3ZSBjYW4ndCB1
c2UgY3RpbWUgYXMgYSAiaV92ZXJzaW9uIiByZXBsYWNlbWVudCBmb3Igb3RoZXINCj4gcmVhc29u
cyB0b28gLSB5b3UgaGF2ZSBmaWxlc3lzdGVtcyBsaWtlIEZBVCAtIHdoaWNoIHBlb3BsZSBkbyB3
YW50IHRvDQo+IGV4cG9ydCAtIHRoYXQgaGF2ZSBhIHNpbmdsZS1zZWNvbmQgKG9yIGlzIGl0IDJz
PykgZ3JhbnVsYXJpdHkgaW4NCj4gcmVhbGl0eSwgZXZlbiB0aG91Z2ggdGhleSByZXBvcnQgYSAx
bnMgdmFsdWUgaW4gc190aW1lX2dyYW4uDQo+IA0KPiBCdXQgaGVyZSdzIGEgc3VnZ2VzdGlvbiB0
aGF0IHBlb3BsZSBtYXkgaGF0ZSwgYnV0IHRoYXQgbWlnaHQganVzdA0KPiB3b3JrDQo+IGluIHBy
YWN0aWNlOg0KPiANCj4gwqAtIGdldCByaWQgb2YgaV92ZXJzaW9uIGVudGlyZWx5DQo+IA0KPiDC
oC0gdXNlIHRoZSAia25vd24gZ29vZCIgcGFydCBvZiBjdGltZSBhcyB0aGUgdXBwZXIgYml0cyBv
ZiB0aGUgY2hhbmdlDQo+IGNvdW50ZXIgKGFuZCBieSAia25vd24gZ29vZCIgSSBtZWFuIHR2X3Nl
YyAtIG9yIHBvc3NpYmx5IGV2ZW4gInR2X3NlYw0KPiAvIDIiIGlmIHRoYXQgZGltIEZBVCBtZW1v
cnkgb2YgbWluZSBpcyByaWdodCkNCj4gDQo+IMKgLSBtYWtlIHRoZSBydWxlIGJlIHRoYXQgY3Rp
bWUgaXMgKm5ldmVyKiB1cGRhdGVkIGZvciBhdGltZSB1cGRhdGVzDQo+IChtYXliZSB0aGF0J3Mg
YWxyZWFkeSB0cnVlLCBJIGRpZG4ndCBjaGVjayAtIG1heWJlIGl0IG5lZWRzIGEgbmV3DQo+IG1v
dW50IGZsYWcgZm9yIG5mc2QpDQo+IA0KPiDCoC0gaGF2ZSBhIHBlci1pbm9kZSBpbi1tZW1vcnkg
YW5kIHZmcy1pbnRlcm5hbCAoZW50aXJlbHkgaW52aXNpYmxlIHRvDQo+IGZpbGVzeXN0ZW1zKSAi
Y3RpbWUgbW9kaWZpY2F0aW9uIGNvdW50ZXIiIHRoYXQgaXMgKk5PVCogYSB0aW1lc3RhbXAsDQo+
IGFuZCBpcyAqTk9UKiBpX3ZlcnNpb24NCj4gDQo+IMKgLSBtYWtlIHRoZSBydWxlIGJlIHRoYXQg
dGhlICJjdGltZSBtb2RpZmljYXRpb24gY291bnRlciIgaXMgYWx3YXlzDQo+IHplcm8sICpFWENF
UFQqIGlmDQo+IMKgwqDCoCAoYSkgSV9WRVJTSU9OX1FVRVJJRUQgaXMgc2V0DQo+IMKgwqAgQU5E
DQo+IMKgwqDCoCAoYikgdGhlIGN0aW1lIG1vZGlmaWNhdGlvbiBkb2Vzbid0IG1vZGlmeSB0aGUg
Imtub3duIGdvb2QiIHBhcnQNCj4gb2YgY3RpbWUNCj4gDQo+IHNvIGhvdyB0aGUgInN0YXR4IGNo
YW5nZSBjb29raWUiIGVuZHMgdXAgYmVpbmcgImhpZ2ggYml0cyB0dl9zZWMgb2YNCj4gY3RpbWUs
IGxvdyBiaXRzIGN0aW1lIG1vZGlmaWNhdGlvbiBjb29raWUiLCBhbmQgdGhlIGVuZCByZXN1bHQg
b2YNCj4gdGhhdA0KPiBpczoNCj4gDQo+IMKgLSBpZiBhbGwgdGhlIHJlYWRzIGhhcHBlbiBhZnRl
ciB0aGUgbGFzdCB3cml0ZSAoY29tbW9uIGNhc2UpLCB0aGVuDQo+IHRoZSBsb3cgYml0cyB3aWxs
IGJlIHplcm8sIGJlY2F1c2UgSV9WRVJTSU9OX1FVRVJJRUQgd2Fzbid0IHNldCB3aGVuDQo+IGN0
aW1lIHdhcyBtb2RpZmllZA0KPiANCj4gwqAtIGlmIHlvdSBkbyBhIHdyaXRlICphZnRlciogYSBt
b2RpZmljYXRpb24sIHRoZSBjdGltZSBjb29raWUgaXMNCj4gZ3VhcmFudGVlZCB0byBjaGFuZ2Us
IGJlY2F1c2UgZWl0aGVyIHRoZSBrbm93biBnb29kIChzZWMvMnNlYykgcGFydA0KPiBvZg0KPiBj
dGltZSBpcyBuZXcsICpvciogdGhlIGNvdW50ZXIgZ2V0cyB1cGRhdGVkDQo+IA0KPiDCoC0gaWYg
dGhlIG5mcyBzZXJ2ZXIgcmVib290cywgdGhlIGluLW1lbW9yeSBjb3VudGVyIHdpbGwgYmUgY2xl
YXJlZA0KPiBhZ2FpbiwgYW5kIHNvIHRoZSBjaGFuZ2UgY29va2llIHdpbGwgY2F1c2UgY2xpZW50
IGNhY2hlDQo+IGludmFsaWRhdGlvbnMsDQo+IGJ1dCAqb25seSogZm9yIHRob3NlICJjdGltZSBj
aGFuZ2VkIGluIHRoZSBzYW1lIHNlY29uZCBfYWZ0ZXJfDQo+IHNvbWVib2R5IGRpZCBhIHJlYWQi
Lg0KPiANCj4gwqAtIGFueSBsb25nLXRpbWUgY2FjaGVzIG9mIGZpbGVzIHRoYXQgZG9uJ3QgZ2V0
IG1vZGlmaWVkIGFyZSBhbGwNCj4gZmluZSwNCj4gYmVjYXVzZSB0aGV5IHdpbGwgaGF2ZSB0aG9z
ZSBsb3cgYml0cyB6ZXJvIGFuZCBkZXBlbmQgb24ganVzdCB0aGUNCj4gc3RhYmxlIHBhcnQgb2Yg
Y3RpbWUgdGhhdCB3b3JrcyBhY3Jvc3MgZmlsZXN5c3RlbXMuIFNvIHRoZXJlIHNob3VsZA0KPiBi
ZQ0KPiBubyBuYXN0eSB0aHVuZGVyaW5nIGhlcmQgaXNzdWVzIG9uIGxvbmctbGl2ZWQgY2FjaGVz
IG9uIGxvdHMgb2YNCj4gY2xpZW50cyBpZiB0aGUgc2VydmVyIHJlYm9vdHMsIG9yIGF0aW1lIHVw
ZGF0ZXMgZXZlcnkgMjQgaG91cnMgb3INCj4gYW55dGhpbmcgbGlrZSB0aGF0Lg0KPiANCj4gYW5k
IG5vdGUgdGhhdCAqTk9ORSogb2YgdGhpcyByZXF1aXJlcyBhbnkgZmlsZXN5c3RlbSBpbnZvbHZl
bWVudA0KPiAoZXhjZXB0IGZvciB0aGUgcnVsZSBvZiAibm8gYXRpbWUgY2hhbmdlcyBldmVyIGlt
cGFjdCBjdGltZSIsIHdoaWNoDQo+IG1heSBvciBtYXkgbm90IGFscmVhZHkgYmUgdHJ1ZSkuDQo+
IA0KPiBUaGUgZmlsZXN5c3RlbSBkb2VzICpub3QqIGtub3cgYWJvdXQgdGhhdCBtb2RpZmljYXRp
b24gY291bnRlciwNCj4gdGhlcmUncyBubyBuZXcgb24tZGlzayBzdGFibGUgaW5mb3JtYXRpb24u
DQo+IA0KPiBJdCdzIGVudGlyZWx5IHBvc3NpYmxlIHRoYXQgSSdtIG1pc3Npbmcgc29tZXRoaW5n
IG9idmlvdXMsIGJ1dCB0aGUNCj4gYWJvdmUgc291bmRzIHRvIG1lIGxpa2UgdGhlIG9ubHkgdGlt
ZSB5b3UnZCBoYXZlIHN0YWxlIGludmFsaWRhdGlvbnMNCj4gaXMgcmVhbGx5IHRoZSAodW51c3Vh
bCkgY2FzZSBvZiBoYXZpbmcgd3JpdGVzIGFmdGVyIGNhY2hlZCByZWFkcywgYW5kDQo+IHRoZW4g
YSByZWJvb3QuDQo+IA0KPiBXZSdkIGdldCByaWQgb2YgImlub2RlX21heWJlX2luY19pdmVyc2lv
bigpIiBlbnRpcmVseSwgYW5kIGluc3RlYWQNCj4gcmVwbGFjZSBpdCB3aXRoIGxvZ2ljIGluIGlu
b2RlX3NldF9jdGltZV9jdXJyZW50KCkgdGhhdCBiYXNpY2FsbHkNCj4gZG9lcw0KPiANCj4gwqAt
IGlmIHRoZSBzdGFibGUgcGFydCBvZiBjdGltZSBjaGFuZ2VzLCBjbGVhciB0aGUgbmV3IDMyLWJp
dCBjb3VudGVyDQo+IA0KPiDCoC0gaWYgSV9WRVJTSU9OX1FVRVJJRUQgaXNuJ3Qgc2V0LCBjbGVh
ciB0aGUgbmV3IDMyLWJpdCBjb3VudGVyDQo+IA0KPiDCoC0gb3RoZXJ3aXNlLCBpbmNyZW1lbnQg
dGhlIG5ldyAzMi1iaXQgY291bnRlcg0KPiANCj4gYW5kIHRoZW4gdGhlIFNUQVRYX0NIQU5HRV9D
T09LSUUgY29kZSBiYXNpY2FsbHkganVzdCByZXR1cm5zDQo+IA0KPiDCoMKgIChzdGFibGUgcGFy
dCBvZiBjdGltZSA8PCAzMikgKyBuZXcgMzItYml0IGNvdW50ZXINCj4gDQo+IChhbmQgYWdhaW4s
IHRoZSAic3RhYmxlIHBhcnQgb2YgY3RpbWUiIGlzIGVpdGhlciBqdXN0IHR2X3NlYywgb3IgaXQn
cw0KPiAidHZfc2VjID4+IDEiIG9yIHdoYXRldmVyKS4NCj4gDQo+IFRoZSBhYm92ZSBkb2VzIG5v
dCBleHBvc2UgKmFueSogY2hhbmdlcyB0byB0aW1lc3RhbXBzIHRvIHVzZXJzLCBhbmQNCj4gc2hv
dWxkIHdvcmsgYWNyb3NzIGEgd2lkZSB2YXJpZXR5IG9mIGZpbGVzeXN0ZW1zLCB3aXRob3V0IHJl
cXVpcmluZw0KPiBhbnkgc3BlY2lhbCBjb2RlIGZyb20gdGhlIGZpbGVzeXN0ZW0gaXRzZWxmLg0K
PiANCj4gQW5kIG5vdyBwbGVhc2UgYWxsIGp1bXAgb24gbWUgYW5kIHNheSAiTm8sIExpbnVzLCB0
aGF0IHdvbid0IHdvcmssDQo+IGJlY2F1c2UgWFlaIi4NCj4gDQo+IEJlY2F1c2UgaXQgaXMgKmVu
dGlyZWx5KiBwb3NzaWJsZSB0aGF0IEkgbWlzc2VkIHNvbWV0aGluZyB0cnVseQ0KPiBmdW5kYW1l
bnRhbCwgYW5kIHRoZSBhYm92ZSBpcyBjb21wbGV0ZWx5IGJyb2tlbiBmb3Igc29tZSBvYnZpb3Vz
DQo+IHJlYXNvbiB0aGF0IEkganVzdCBkaWRuJ3QgdGhpbmsgb2YuDQo+IA0KDQpNeSBjbGllbnQg
d3JpdGVzIHRvIHRoZSBmaWxlIGFuZCBpbW1lZGlhdGVseSByZWFkcyB0aGUgY3RpbWUuIEEgM3Jk
DQpwYXJ0eSBjbGllbnQgdGhlbiB3cml0ZXMgaW1tZWRpYXRlbHkgYWZ0ZXIgbXkgY3RpbWUgcmVh
ZC4NCkEgcmVib290IG9jY3VycyAobWF5YmUgbWludXRlcyBsYXRlciksIHRoZW4gSSByZS1yZWFk
IHRoZSBjdGltZSwgYW5kDQpnZXQgdGhlIHNhbWUgdmFsdWUgYXMgYmVmb3JlIHRoZSAzcmQgcGFy
dHkgd3JpdGUuDQoNClllcywgbW9zdCBvZiB0aGUgdGltZSB0aGF0IGlzIGJldHRlciB0aGFuIHRo
ZSBuYWtlZCBjdGltZSwgYnV0IG5vdA0KYWNyb3NzIGEgcmVib290Lg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

