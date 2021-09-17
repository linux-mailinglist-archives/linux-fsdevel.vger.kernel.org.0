Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43B340FA46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbhIQOh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 10:37:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25137 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhIQOh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:37:57 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H2QZ2Z001912;
        Fri, 17 Sep 2021 07:36:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zDZtAe3fXnK2dotWlnRPM36VBQAt45cHPMQV/i2dt4A=;
 b=MoC6xl3nH5R5UHszA/VO4aCOuiDCyoLzgr2hgJD2GGLB8acDwWo7n29WJMACMe6su0Ys
 tft05Z1GHc2PIr6WRGDNek1V0cDM3X47LJ3S9giLhXAK/0PmWsSFjoIxmiU30avRF24f
 8DKwQTMPUhEI3Oe361/gi+5yM+Mka5/xif0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b4j7w3u88-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Sep 2021 07:36:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 07:36:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlgFLWutlbgy8PDhJs0qQpmahnTRyl1w3ntPhGsTm8738jScs/hP7qZ0fuDRFfVfojkuGtjM8YI4LAgtjYMQCa0JWQLNWhMp2jo1TvGQIkZvJBYNWCW/+eO0YP5J/kfdmh3AJyfFU6tSTd4B0LMEKk/MV2j/RKqS8tLK6q33OpTdLgRT1m8mahlkbaeGTzCKDCB8oY8ErFZjYTFr2nUyXJm3vtEjjrWzsaOCJj15oKTYKeP+vJYn4OQRPQjrVtzIQ7+QqumUl2e74NTDo7kH1CfvZRIgTymkLKWLbaD9q98ea46d2rzeDgCj8KfL58O07ErwnusXRQYgbbL6qnUlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zDZtAe3fXnK2dotWlnRPM36VBQAt45cHPMQV/i2dt4A=;
 b=eJbfRHBUOG8xZF8Ui1xzHsiGmz3wrqahnGqn2KWxa76+fmxdM1lNdss2Jf236/JGfIc1cSAFpSdw6tLu4l3FeiPs/y61Vmvqwjx1weisWMxaD3kfeeNOe5yVxBs5YnERUms37WjPCDh7OaPekP94LRgULyyTEeXTsFy9hHsCOXMpJ6wto57RCJGSX7QxekUVQSbHuA0IU9/SZYBnHVBMLTkhEoTVZw7+xiU1mo2txUf1mNmwcjIzYX81Y4cdcpHiS/fuOLZtNTtqmwVKSJ2QQMiV8E15GIyzpJyDdE2nV15aZHGaUyeqA1G3Nf8HSpB/mVjyzUH0WepMcPZ8dGx9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4924.namprd15.prod.outlook.com (2603:10b6:303:e3::16)
 by MW2PR1501MB1961.namprd15.prod.outlook.com (2603:10b6:302:12::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 14:36:31 +0000
Received: from CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::409a:5252:df3c:dabb]) by CO1PR15MB4924.namprd15.prod.outlook.com
 ([fe80::409a:5252:df3c:dabb%5]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 14:36:31 +0000
From:   Chris Mason <clm@fb.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
CC:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Thread-Topic: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Thread-Index: AQHXqlkZYMl5M/taiEScAPg40L4dIqulY1sAgAAErQCAAAXjAIAACWeAgAFowYCAAAb4gIAAOcsAgAAGTgCAAO5xgIAAFxwAgAAGf4CAABrsAA==
Date:   Fri, 17 Sep 2021 14:36:31 +0000
Message-ID: <323217C4-92F6-404B-857A-D40CDE6CADBC@fb.com>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu> <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
 <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
 <261D65D8-7273-4884-BD01-2BF8331F4034@fb.com>
 <20210916210046.ourwrk6uqeisi555@meerkat.local>
 <f8561816ab06cedf86138a4ad64e7ff7b33e2c07.camel@HansenPartnership.com>
 <20210917123654.73sz5p2yjtd3a2np@meerkat.local>
 <16bf12514f29a1b233c98cc8835f5e1b9331f719.camel@HansenPartnership.com>
In-Reply-To: <16bf12514f29a1b233c98cc8835f5e1b9331f719.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: hansenpartnership.com; dkim=none (message not signed)
 header.d=none;hansenpartnership.com; dmarc=none action=none
 header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3b0c111-dcdd-4891-3837-08d979e88a89
x-ms-traffictypediagnostic: MW2PR1501MB1961:
x-microsoft-antispam-prvs: <MW2PR1501MB1961576A3413352410FE03D1D3DD9@MW2PR1501MB1961.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G8RYIbxNGK4+CLesjrkYHSrEoLG38ZIku+1SBSpuhhy+nxmIfsliGw4Wy4bQfu289MAF9oGjmdYFjYND1xDdanvL8yjemPDA4d2+57HzpbnDcdNM11OJd76TOeKIHniJQwN1OuqaL63yjgiAjqSccsyLZdhEMK6Ju0e46xzt6kZNYa6LIjdTBp2RPK8RvnjQg36WaN1mOnul6MVrUdw1kRZtXuXM2RVViEATVB7EBMTRs80nqvdSlN/bDCqZjR+9eYyyZhZWKKYcgV25UJ5ahAyTO3DspphMcK7Y5p9fITqY4kW5C6TJk6pLzJLEh2AqflnsUIZibviZcrObhN4THFSXjPMNihO5xTbh8sNXdLbCu90WfPI/f2/zkaL/oEqVO2olxuPNOM0gP6tGJ87J4vFhfKpOqu/2xpKK6AY2s5wFTB/nodANoeGCIHZj9Bdx1IZWl/VK1SAWzYcMmdG+mC2vF14PwUa0UEH01WCmwKfB85xHaLcypIZ/IAMgiNrTyHJpLxkzwG2G48YmWl9mig8lPwfar3HeUm1pmmQdfBmIMrcRmaLOOhYDGG3PvbwxDgb8JTukeg8ZJxTVMprNrYA3S3F4j1xlQjzd78Eq6WVZwOI1t6dx0AhBcJZo1rXNl2IAvKVTfGpIaiAfnVRDOD5pzLyrQen2Mx/hUsd488X9NeiVjZF+duitIFENLgPyBGx/SHu6mtdtVTK8NZ1cMgJ+uQQiEm/Kh67iCQsMdZk3F3q0TGFxolurvu1m5IIt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4924.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(122000001)(38070700005)(38100700002)(316002)(54906003)(6916009)(64756008)(2906002)(186003)(86362001)(5660300002)(66446008)(66946007)(66476007)(4326008)(66556008)(76116006)(91956017)(71200400001)(7416002)(6512007)(36756003)(83380400001)(8676002)(8936002)(2616005)(966005)(6486002)(33656002)(478600001)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmFmajNFVFo5NzM2YVR6TUp5ZVNNVTlwdFlUb3ZxakJoaUI3TWwrQWJiR2hV?=
 =?utf-8?B?c0dvZWpiZml5VVVUeTZlQmduRVNtVDNMQnovODRKd2NIaFdEUFk2dnFISFpX?=
 =?utf-8?B?MmsrN1JVNnB6NW9Tb3RjZS9QckRFY2JrdUpLRnBIbCtDTlhvdGp2NVk4TVha?=
 =?utf-8?B?NHhrTDV5WVkxUzJYVkNoSkVCbXpZaWx2enNvWnNVYXc0TkYrK0UvTXBIVndm?=
 =?utf-8?B?YU42VmY2ZHEwTVdqQkZvak4yNkJodWhlK29BUkIxN2psWlZJRFZKOE9ka1Zo?=
 =?utf-8?B?YW1VNjlmUjRBbDVuUSs2ZkQyb0tzZ213ckpJMS9UQit6a1cxOTJQS3NSdE5Y?=
 =?utf-8?B?ZlRnSkdaWFd2UmxhQU8vRkc1bno4TGFVQXdkMWIvZDVHc3BZOVVZOHNHbU4w?=
 =?utf-8?B?c28yZ01XNkROQXU3UmxmU2o5aU4vaWN3OE1BMHJnZkQ0VVp6bFB4cmRydHdh?=
 =?utf-8?B?MlBES09jM3FmRmFNZ3A1YU9xMHlkci81M2VCbXVLai9qMjBmSS83QUt5OEtL?=
 =?utf-8?B?VTNpVVFqWmFLd0pmSUNiaFN2Z0hoQit1dnZQbk1FRmZJYnBhSURNSWVKZ1Y0?=
 =?utf-8?B?czBGMGppODQ1amFTSVBGeFpwRU1hMmcwbVNPdWRpVllwc1lEbFFWZ1BJc3I0?=
 =?utf-8?B?K1J2b01SQWkxa3R0VjRzUkZHdnE3QzBnenVLTVRRWkIwSWlNM04weEFqdDVS?=
 =?utf-8?B?a0RhQUFCallQN1dkajhmelQzcFZnQ29QWG9jeWhzMjE5Nlp6SFJiSWcyRXd0?=
 =?utf-8?B?NzlpNDczdGF2NVBOY2hPTU9MLzg2TEY5aCtTV3lWbjVid1JCN1d4WTgrSWdI?=
 =?utf-8?B?bldrOElYYlk5NXJTdjZnRjlzMlRhNUp5cDlQTWxlWUxkbm1HZ09RUFlPcjJV?=
 =?utf-8?B?TUMwRFM5aXRjWVVJOFg0K28waXk4WkVPSDRLdUhabU80YUhOSU5FSWdGVWhY?=
 =?utf-8?B?QW52VTJtZ3ZSVW0xM2FvQ1RmQWJvY0czNHR5bndjb0l5bGYydExVT2FLOEhW?=
 =?utf-8?B?YVRqSjd4ZGMxdVphQkpRbWFVUTJKUXB4Mk5FYmtLTFJUOVB1QXB5QjFzRmdn?=
 =?utf-8?B?QnFkMEQ3aWJRSk4xN08vL041eUd6UmFmcFJITTlSY3dlZGtGNHhiY3NlbXZM?=
 =?utf-8?B?T1FDOFg4bVBzWWlaenZJcXZiMU9sMUwwTGZiUSthWFFTQXI2UUU1aUQ0WXBu?=
 =?utf-8?B?OUtVb0d4K2t5ZUVMWjdwMlF3cU5LUGFwSnZIaHcxSjdQaFo0bFA1S212UVVP?=
 =?utf-8?B?ZjBhV0tCalplT0M0Q3RZZldERi85SkMwVzZYdnNWdVByMUQ4NjN0UCtEckJ4?=
 =?utf-8?B?NWJxWXRNY2QwL0lqYjk1SVlhaHp2enBnd0ZDY1FhUDdlMUJ4dU1NTW1DWDl0?=
 =?utf-8?B?c1lyZTMwUkJEaHlxZURDMDUyQ3VuUVBaUEx2OTc5VXJUT2RSejlYSXVVdlNu?=
 =?utf-8?B?VTc3dXBYNmFhaytYSkZKQ3FnYXF2KzRJaTVzUm5IaHoxWVFXbHkrN0VkWnlG?=
 =?utf-8?B?Yk1IbndmbTA0NVBiaFZYMlBwTkt5MEFBN0wxdXJlbVJmTVFoaFpuWFllME1B?=
 =?utf-8?B?MEJGOVh2bDdtSzVEN0FIYnFyd1RDdFpVdVQ1S1RHZi9Zbk9xQWxWRXFJVXlB?=
 =?utf-8?B?MkpSKzY1Wm5RaGFWOWZrUktFelJFMFVZdEZORjN4V3NFOHN5VitJSWp5Y3h5?=
 =?utf-8?B?K1REWEFnYUVsbFlRT1JrSFh0KzVzVFNKZVgwSHdEa0t2Ryt3ZTAzYXdoWEpm?=
 =?utf-8?B?ZHZWZGNVQ1hjYUdVVFJTTUNVbWxYOGVpbzRLaHRVTndhcUgwWlhMYWNDL3Js?=
 =?utf-8?Q?0lucpayL7QguLDDD6Yl1Aobkq3KPnI6BWEQnY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <27961ECA45593147B6956BCF5DE4F238@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4924.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b0c111-dcdd-4891-3837-08d979e88a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 14:36:31.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYja9B0e20FXeJd1GPUlW4tg9f8id+hu6J7RYRESMvSoZO0CTT7L6eEV59DsZj/m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB1961
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: skGXGOPElL5sbClnCtOTuXrjqqeF4WPE
X-Proofpoint-GUID: skGXGOPElL5sbClnCtOTuXrjqqeF4WPE
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_06,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=855
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109170093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIFNlcCAxNywgMjAyMSwgYXQgOTowMCBBTSwgSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5C
b3R0b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAy
MS0wOS0xNyBhdCAwODozNiAtMDQwMCwgS29uc3RhbnRpbiBSeWFiaXRzZXYgd3JvdGU6DQo+PiBP
biBGcmksIFNlcCAxNywgMjAyMSBhdCAwNzoxNDoxMUFNIC0wNDAwLCBKYW1lcyBCb3R0b21sZXkg
d3JvdGU6DQo+Pj4+IEkgd291bGQgY2F1dGlvbiB0aGF0IEdvb2dsZSBkb2NzIGFyZW4ndCB1bml2
ZXJzYWxseSBhY2Nlc3NpYmxlLg0KPj4+PiBDaGluYSBibG9ja3MgYWNjZXNzIHRvIG1hbnkgR29v
Z2xlIHJlc291cmNlcywgYW5kIG5vdyBSdXNzaWENCj4+Pj4gcHVycG9ydGVkbHkgZG9lcyB0aGUg
c2FtZS4gUGVyaGFwcyBhIHNpbWlsYXIgZWZmZWN0IGNhbiBiZQ0KPj4+PiByZWFjaGVkIHdpdGgg
YSBnaXQgcmVwb3NpdG9yeSB3aXRoIGxpbWl0ZWQgY29tbWl0IGFjY2Vzcz8gQXQNCj4+Pj4gbGVh
c3QgdGhlbiBjb21taXRzIGNhbiBiZSBhdHRlc3RlZCB0byBpbmRpdmlkdWFsIGF1dGhvcnMuDQo+
Pj4gDQo+Pj4gSW4gZGF5cyBvZiBvbGQsIHdoZW4ga25pZ2h0cyB3ZXJlIGJvbGQgYW5kIGNsb3Vk
IHNpbG9zIHdlcmVuJ3QNCj4+PiBpbnZlbnRlZCwgd2UgaGFkIGFuIGFuY2llbnQgbWFnaWMgaGFu
ZGVkIGRvd24gYnkgdGhlIG9sZCBnb2RzIHdobw0KPj4+IHNwb2tlIG5vbiB0eXBlIHNhZmUgbGFu
Z3VhZ2VzLiAgVGhleSBjYWxsZWQgaXQgd2lraSBhbmQgZXRoZXJwYWQNCj4+PiAuLi4gY291bGQg
d2UgbWFrZSB1c2Ugb2Ygc3VjaCB0b29scyB0b2RheSB3aXRob3V0IGNvbW1pdHRpbmcgaGVyZXN5
DQo+Pj4gYWdhaW5zdCBvdXIgY2xvdWQgb3ZlcmxvcmRzPw0KPj4gDQo+PiBZb3UgbWVhbiwgbGlr
ZSBodHRwczovL3BhZC5rZXJuZWwub3JnID8gOikNCj4+IA0KPj4gSG93ZXZlciwgYSBsYXJnZSBw
YXJ0IG9mIHdoeSBJIHdhcyBzdWdnZXN0aW5nIGEgZ2l0IHJlcG8gaXMgYmVjYXVzZQ0KPj4gaXQg
aXMgYXV0b21hdGljYWxseSByZWRpc3RyaWJ1dGFibGUsIGNsb25hYmxlLCBhbmQgdmVyaWZpYWJs
ZSB1c2luZw0KPj4gYnVpbHRpbiBnaXQgdG9vbHMuIFdlIGhhdmUgZW5kLXRvLWVuZCBhdHRlc3Rh
dGlvbiB3aXRoIGdpdCwgYnV0IHdlDQo+PiBkb24ndCBoYXZlIGl0IHdpdGggZXRoZXJwYWQgb3Ig
YSB3aWtpLiBJZiB0aGUgZ29hbCBpcyB0byB1c2UgYQ0KPj4gZG9jdW1lbnQgdGhhdCBzb2xpY2l0
cyBhY2tzIGFuZCBvdGhlciBpbnB1dCBhY3Jvc3Mgc3Vic3lzdGVtcywgdGhlbg0KPj4gaGF2aW5n
IGEgdGFtcGVyLWV2aWRlbnQgYmFja2VuZCBtYXkgYmUgaW1wb3J0YW50Lg0KPiANCj4gSSB0aGlu
ayB0aGUgZ29hbCBpcyB0byBoYXZlIGEgbGl2aW5nIGRvY3VtZW50IHRoYXQgcmVjb3JkcyB3aG8g
c2hvdWxkDQo+IGFjaywgd2hhdCB0aGUgZGVzaWduIGdvYWxzIGFyZSB3aG8gaGFzIHdoYXQgY3Vy
cmVudCBjb25jZXJucyBhbmQgaG93DQo+IHRoZXkncmUgYmVpbmcgYWRkcmVzc2VkIGFuZCB3aGF0
IHRoZSBzdGF0dXMgb2YgdGhlIHBhdGNoIHNldCBpcy4gDQo+IEFjdHVhbGx5IGNvbGxlY3Rpbmcg
YWNrcyBmb3IgdGhlIHBhdGNoZXMgd291bGQgYmUgdGhlIGpvYiBvZiB0aGUgYXV0aG9yDQo+IGFz
IGl0IGlzIHRvZGF5IGFuZCB2ZXJpZmljYXRpb24gd291bGQgYmUgdmlhIHRoZSBwdWJsaWMgbGlz
dHMuDQoNClRoYW5rcyBLb25zdGFudGluIGZvciBicmluZ2luZyB1cCBpc3N1ZXMgd2l0aCBnb29n
bGUgZG9jcy4gIEkgYXNzdW1lZCBkaWZmZXJlbnQgZ3JvdXBzIG9mIHBlb3BsZSB3b3VsZCBzdG9y
ZSBzdGF0ZSBkaWZmZXJlbnRseSwgYnV0IGRpZG7igJl0IHRoaW5rIG9mIHRoaXMgcHJvYmxlbS4g
IE9uZSBuaWNlIGZlYXR1cmUgYWJvdXQgZ29vZ2xlIGRvY3MgaXMgeW91IGNhbiBtYXJrIGlzc3Vl
cyBhcyByZXNvbHZlZCBldGMsIGJ1dCBvYnZpb3VzbHkgcGVvcGxlIGNhbiBzaW11bGF0ZSB0aGF0
IGluIG90aGVyIHdheXMgd2l0aCBldGhlcnBhZC4NCg0KLWNocmlzDQoNCg==
