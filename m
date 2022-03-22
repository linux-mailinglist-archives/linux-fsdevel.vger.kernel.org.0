Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818B24E38A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 06:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiCVFzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 01:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiCVFzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:55:51 -0400
Received: from mx04.melco.co.jp (mx04.melco.co.jp [192.218.140.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B26246;
        Mon, 21 Mar 2022 22:54:23 -0700 (PDT)
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx04.melco.co.jp (Postfix) with ESMTP id 4KN0zy4MwRzMwSH9;
        Tue, 22 Mar 2022 14:54:22 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 4KN0zy3fwpzMqZ1F;
        Tue, 22 Mar 2022 14:54:22 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr06.melco.co.jp (Postfix) with ESMTP id 4KN0zy3cg5zMwX19;
        Tue, 22 Mar 2022 14:54:22 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 4KN0zy3Z29zMr4px;
        Tue, 22 Mar 2022 14:54:22 +0900 (JST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (unknown [104.47.23.176])
        by mf04.melco.co.jp (Postfix) with ESMTP id 4KN0zy3NMbzMr4pj;
        Tue, 22 Mar 2022 14:54:22 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZY0y+ZfeNZas9I/Es2Gz2nGH1fLiZTL782CQHpvQHY5ckBZg9cAV3MCKzbnNUahVXWRLOpEiqX8lEUfxTDEwPw/LiJcukf9m31ibKlF6WVgw8rsX+NxC6EDIpYryJlrK4p0S0A59nHha3h4G1PJ8ZuAkgRbFZ5X1gjP4Cuj31pjv37QmJxL8hgpcX8ZBpfQMpgAzn08ORMg7ss8tGDJTj29vNp4l4CN6oKhmIsweXHMYNdwuqx3Ob0YYeRyQ9wbUjH0DNnI1FEGCRIJ02zfZBwhH7bm9nrmZ1YysMHnh3oUas7w0hMlf7fIY2Alia3U9Sbdy0ZuVPehh8a4Ic1Ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXfyENH85JA6JCwD8bHXMtHU0XpIaRVxkMQ/nh2iwgk=;
 b=W4gPJ4b9dlbf86U4YRLu0EJJqDdkxAV9vzm9/VPdzSBlnqg+AVrdydKHdF194qOrB8hZhwkvOzlSs0XARc6oTxxXpimn1q/hHuB8SAXw+Fmy0U3MXCKJ7cMan9p/FUIAAmQVQyRuW9Bly+Vq0oI/zrJAydRFm3DP9GQd30vOoMDhdjJ6Bd36CwAW1TyJEAfyfWJkbvZiBSXwMgewq7nGh1craIpecjPSaE6lZv3TCps1/s96ZFbJKFtw05irkDd3ystfnSvyNkGeTtKBGUPf/19ZWRU9W1W3BEepK7r2UPnwZqQOJDvFzK/6asV3Eop73XeStA82S9yU2ghxfuTUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXfyENH85JA6JCwD8bHXMtHU0XpIaRVxkMQ/nh2iwgk=;
 b=NWJ3XLH7Fjgn/fLjUQreDL99OjXOXfhiNZDAqXx+aZf4dqIp65bYfT34J9RPjkkd/7p0Kqfs6Awmu6Qq88CHSVJLC8H85IqIzhRF/Vhz9xmf1xpwB4xRsLXJAoXlvHUgWWzOrQoVbF00oGJVeMmkWPiAeuWH2vOvdrq0kin+75I=
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8)
 by TYWPR01MB9774.jpnprd01.prod.outlook.com (2603:1096:400:234::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 05:54:21 +0000
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::493e:4ed3:1705:ee86]) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::493e:4ed3:1705:ee86%2]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 05:54:21 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "'Yuezhang.Mo@sony.com'" <Yuezhang.Mo@sony.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        'Namjae Jeon' <linkinjeon@kernel.org>,
        "'Wataru.Aoyama@sony.com'" <Wataru.Aoyama@sony.com>,
        "'Andy.Wu@sony.com'" <Andy.Wu@sony.com>
Subject: RE: [PATCH v3] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH v3] exfat: do not clear VolumeDirty in writeback
Thread-Index: Adg6lzDjhk7fjGoDQ3egmYNh+h6C3QDGOJ5g
Date:   Tue, 22 Mar 2022 05:51:41 +0000
Deferred-Delivery: Tue, 22 Mar 2022 05:54:00 +0000
Message-ID: <TYAPR01MB5353F1CFE04FC4B91C353B1F90179@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <HK2PR04MB3891EE32B58A61D3ED9944CE81139@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB3891EE32B58A61D3ED9944CE81139@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dc.MitsubishiElectric.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 735ce97b-d6b1-40ab-06c7-08da0bc86912
x-ms-traffictypediagnostic: TYWPR01MB9774:EE_
x-microsoft-antispam-prvs: <TYWPR01MB9774A91F88E1C9D5D89F2D3690179@TYWPR01MB9774.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vn8S/whysDMhZ2uwtJJ33jFwScDfKZYM7nh0iS95QzKKqW8mKUc4/Pie8uxrGxK7lVpYIodBcnU3l+8gb6gXu/EtW8H2t4rSAHLF/Oi5sGF6F2HrG+mPR6RqfLIFgpgRg1MbJmtnpoea9OQWYgAdj70JCvWdoCpG4duX5cEhao66A7eYL+ClZc03UBHdnxXoX8xT25qfORoUeLEcBZ79qBkq8ShJpCucZjAvjImcem6oIuFyBHvBbLRMlS0jP1Czh4ne8tCKIATaso8EOyhroL+vF6Z78HOsxVAotEBvM8Gem0nwxsUr5Ho3LBA4mESAlmfETJnu6r/7xfutIcfkw3go7CaLwCr2rJWRt2OITQoAZVllK5uFP4vjcaG7s8R/htgtL8+WUNW604G/Y7DffpLm6apIDXUwZriwv0P63QQU3pMyZSuHw0Zyn/DzCgH05ggyiSsWf35McTJPO8T/66U5botyp3ekytNXYkaAlXW3jnE7D4eBMO0erUkKgZlkJKt0/yLRpaMT15Le66CCbzfiKoI4dXDNU7W8wzwj+ZjlWGBfkMrVNi8cTQma215iUI5Td+0STUPfCPLGawShum3pKx57S4c6RYDgOl2ms4B84pjaAkd0HpFWQLhWihkKz6Bqu9CvQZGiKPAaQPUDYAMaCGBCkqRllQ9K/dpApd9J/RRbrllC+3vi+OGsX7lPxcC2z4d7vwQmPcrn2gJZkL/JpwX+XTy9bOCnpizMlns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5353.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(5660300002)(54906003)(8936002)(186003)(26005)(6916009)(52536014)(38070700005)(316002)(83380400001)(66946007)(508600001)(66556008)(66476007)(38100700002)(64756008)(86362001)(7696005)(6666004)(9686003)(2906002)(76116006)(6506007)(33656002)(8676002)(71200400001)(4326008)(122000001)(66446008)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3RMeDlSM0tnLzF6U3lhN01oSkI3U0s2eXpyck5DVXhPaExFZGlEeUZ0Q1Rx?=
 =?utf-8?B?ajU2YTlrNGJWK0xHcUFuM2xjalFpNkZiemcrQlkvT2tkc3N5YS90N1htZlFh?=
 =?utf-8?B?T0dsWERPZVlZU2krMk1LL3dUTnJjeGYzbkNnVEd3YlhacW9tbE4vWVM4ZURG?=
 =?utf-8?B?Q1luZjUwTWMramo5N1QrREg3M3d4ZGpFV3Z5QS96ZldVZ3VDa3gyUVNmeTVn?=
 =?utf-8?B?cTdKY1lBMVMvcyt6d0g3UkVsdnd3bXo3TFd3aUZvT3llNytNbERmK09mNzMz?=
 =?utf-8?B?eVF2YWN6YlhpUGV5cTYvaGxtWU1Ed0RUMlhiK2cyQUdLcGZoYzZQMEt3OTZu?=
 =?utf-8?B?S3BJeEw5ME1HNTREYU9MUzd6WnZFRHFLRmVzbGkzY09xSWFWR3Y3a3RDUXBF?=
 =?utf-8?B?WWtCNmt3bDh3aWpqSUp1UUxGWGJEaDZHRzBUMGFoYVovVFRQaVJsL215OUgr?=
 =?utf-8?B?TTBwNWwvMTlCNlB3Ym84Um0wVm5vMkQ5bzY2T2NvNWx5eElid1NoSHRTNHI3?=
 =?utf-8?B?bUNWajE0eG1TN3lEeG9pbGlxRWN1azBsa1Z1THBGZUNSTEFrRGJidEVRZm5V?=
 =?utf-8?B?S1ZEZjJCeU54ZEVPNngyY0FKdXdnOURQUnBHQUs1MmVDNFNmZ3ZVVWFHL3hS?=
 =?utf-8?B?WWU3QlNWdTBZZ3RSUS9vVXE2cXhPNGdJZXJQcUZJNTVXdTZoRXpweVp2TTBo?=
 =?utf-8?B?QWJFUXNMZHEzNUU3aFZZWGpBN05sQm1uR2FUWnJwQ2pHbjNNWTlQUnRxMGh2?=
 =?utf-8?B?MkdFUXlndTIzelp2TW1jcTc0cTlmYmRyTFViV3VpWmkwYnpncDQrbEs5RytY?=
 =?utf-8?B?cktGazZ3a2UyV0hKUTVKV0hXS01XbU9xT0w5aVhqNFdvRzNsQ2VlNXQ4SzBE?=
 =?utf-8?B?WWE4ek1HdGtXaExKMkFmbldTS0RkRnFrVUlJYjhRT2gxYUlDcVRlbmU1MnRm?=
 =?utf-8?B?NVJxVG5IbzZhT0drVVdVV1kvUUhrTlgyZVJ6RmhjYThPT3BUMXhwQ0ZMUVBj?=
 =?utf-8?B?UnJsMWNQSGVnS3Q3NVF0c2l5dXIyUEZHM0x0VmQxTXJ1OGxFWEl2RXI0M0VN?=
 =?utf-8?B?dHNIb1Y4MHh0MjN3eHllczVVZEZURkpvcVpsZFhpYWJlR2pYQThVeDV6bmhu?=
 =?utf-8?B?TXAzUTVUNlp4SmJZbEk5eXBKeTNOMnNVNXZHdUZvMWhKQTIyWVQyVVZoNjRP?=
 =?utf-8?B?Wkd0eEcxT3lvNVlBS0RCTXlWSnNOdDFPeFVZZ28renlkQXQzenNIb3ZkYUlh?=
 =?utf-8?B?QlVQaWRodVNYTDUrcHAxazZNbU1hK0t2eVVtUXlmdWozbHBTa0FUU0JFbURN?=
 =?utf-8?B?bW96WE1HQ3lDMFoxUE9nYTRqTklYL3g1a0trTlBPeVNWRmEvTS9yYUhqanha?=
 =?utf-8?B?ZERDTnhkdWhVd2JLZWNLcnlRcGZYcFRrUTRGQzQ2RTRuZlY5WHN0NzhtZUxq?=
 =?utf-8?B?ZGRnaE9qSTdhcVA3U3kyaWtvd3dyeDllNmJ2djJCYzEvVW5xTHkwTER1aFlJ?=
 =?utf-8?B?a0FiWlpjZ1BMekc3NFB2dnBXNktiQWlIVWVCc3RZUmRMWnJVWlRXakhvUEVr?=
 =?utf-8?B?S0xra0JrNERqcXdGKzlMamFYT2dIVGxZRFE4V01ITDh2d1EvM1ZHbnd1WHhl?=
 =?utf-8?B?VUF6VEQzL0V6RkFlS1FKcTJSVktMc3BjS0JOeXBraUtBVFBJb2hQTlpCdW9V?=
 =?utf-8?B?QmN3Vk9uYkNseWc1L211Y2twc2NtQWVwQXdyRW9xMUNZRDVHTHh6a2ZxRlpq?=
 =?utf-8?B?bUxaYU9MY2JRTUd3NjNTelZzTGk4NnJwTnpQY1RXa2llSm9TVEFVSVh6Nkhp?=
 =?utf-8?B?R0RDRGl5Y2NTU0FoeG5Kako2S3V2bTBqRmRPNXB5YVJ3dHhYeHBwS0NxUU1a?=
 =?utf-8?B?OVZMcGFSNGFlYVRqd0lIM0pIVVRUTVRiYkVVdHYzR1hqNkxIR1VIYlVHY1J3?=
 =?utf-8?Q?DWh/s+swLfnEVn3A45AHJSnWdHe6AtSL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5353.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735ce97b-d6b1-40ab-06c7-08da0bc86912
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 05:54:20.9875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5put3fqsK1FYkpTXLWZFFdzvFaQP5ffCdSxBm9qTApK/pSXkCE40jWfqASVRaX9yRs7Ddpj6uNFMLeNMlkx51Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9774
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBCZWZvcmUgdGhpcyBjb21taXQsIFZvbHVtZURpcnR5IHdpbGwgYmUgY2xlYXJlZCBmaXJzdCBp
biB3cml0ZWJhY2sgaWYgDQo+ICdkaXJzeW5jJyBvciAnc3luYycgaXMgbm90IGVuYWJsZWQuIElm
IHRoZSBwb3dlciBpcyBzdWRkZW5seSBjdXQgb2ZmIA0KPiBhZnRlciBjbGVhbmluZyBWb2x1bWVE
aXJ0eSBidXQgb3RoZXIgdXBkYXRlcyBhcmUgbm90IHdyaXR0ZW4sIHRoZSBleEZBVCBmaWxlc3lz
dGVtIHdpbGwgbm90IGJlIGFibGUgdG8gZGV0ZWN0IHRoZSBwb3dlciBmYWlsdXJlIGluIHRoZSBu
ZXh0IG1vdW50Lg0KPiANCj4gQW5kIFZvbHVtZURpcnR5IHdpbGwgYmUgc2V0IGFnYWluIGJ1dCBu
b3QgY2xlYXJlZCB3aGVuIHVwZGF0aW5nIHRoZSANCj4gcGFyZW50IGRpcmVjdG9yeS4gSXQgbWVh
bnMgdGhhdCBCb290U2VjdG9yIHdpbGwgYmUgd3JpdHRlbiBhdCBsZWFzdCBvbmNlIGluIGVhY2gg
d3JpdGUtYmFjaywgd2hpY2ggd2lsbCBzaG9ydGVuIHRoZSBsaWZlIG9mIHRoZSBkZXZpY2UuDQo+
IA0KPiBSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCj4gLS0tDQo+IA0KPiBDaGFu
Z2VzIGZvciB2MjoNCj4gICAtIENsZWFyIFZvbHVtZURpcnR5IHVudGlsIHN5bmMgb3IgdW1vdW50
IGlzIHJ1bg0KPiANCj4gQ2hhbmdlcyBmb3IgdjM6DQo+ICAgLSBBZGQgUkVRX0ZVQSBhbmQgUkVR
X1BSRUZMVVNIIHRvIGd1YXJhbnRlZSBzdHJpY3Qgd3JpdGUgb3JkZXJpbmcNCj4gDQo+ICBmcy9l
eGZhdC9maWxlLmMgIHwgIDIgLS0NCj4gIGZzL2V4ZmF0L25hbWVpLmMgfCAgNSAtLS0tLQ0KPiAg
ZnMvZXhmYXQvc3VwZXIuYyB8IDEwICsrLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9leGZh
dC9maWxlLmMgYi9mcy9leGZhdC9maWxlLmMgaW5kZXggDQo+IGQ4OTBmZDM0YmIyZC4uMmY1MTMw
MDU5MjM2IDEwMDY0NA0KPiAtLS0gYS9mcy9leGZhdC9maWxlLmMNCj4gKysrIGIvZnMvZXhmYXQv
ZmlsZS5jDQo+IEBAIC0yMTgsOCArMjE4LDYgQEAgaW50IF9fZXhmYXRfdHJ1bmNhdGUoc3RydWN0
IGlub2RlICppbm9kZSwgbG9mZl90IG5ld19zaXplKQ0KPiAgCWlmIChleGZhdF9mcmVlX2NsdXN0
ZXIoaW5vZGUsICZjbHUpKQ0KPiAgCQlyZXR1cm4gLUVJTzsNCj4gDQo+IC0JZXhmYXRfY2xlYXJf
dm9sdW1lX2RpcnR5KHNiKTsNCj4gLQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jIGluZGV4IA0KPiBhZjRl
YjM5Y2MwYzMuLjM5YzliZGQ2YjZhYSAxMDA2NDQNCj4gLS0tIGEvZnMvZXhmYXQvbmFtZWkuYw0K
PiArKysgYi9mcy9leGZhdC9uYW1laS5jDQo+IEBAIC01NTQsNyArNTU0LDYgQEAgc3RhdGljIGlu
dCBleGZhdF9jcmVhdGUoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3Qg
aW5vZGUgKmRpciwNCj4gIAlleGZhdF9zZXRfdm9sdW1lX2RpcnR5KHNiKTsNCj4gIAllcnIgPSBl
eGZhdF9hZGRfZW50cnkoZGlyLCBkZW50cnktPmRfbmFtZS5uYW1lLCAmY2RpciwgVFlQRV9GSUxF
LA0KPiAgCQkmaW5mbyk7DQo+IC0JZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KHNiKTsNCj4gIAlp
ZiAoZXJyKQ0KPiAgCQlnb3RvIHVubG9jazsNCj4gDQo+IEBAIC04MTIsNyArODExLDYgQEAgc3Rh
dGljIGludCBleGZhdF91bmxpbmsoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCANCj4gZGVudHJ5
ICpkZW50cnkpDQo+IA0KPiAgCS8qIFRoaXMgZG9lc24ndCBtb2RpZnkgZWkgKi8NCj4gIAllaS0+
ZGlyLmRpciA9IERJUl9ERUxFVEVEOw0KPiAtCWV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYik7
DQo+IA0KPiAgCWlub2RlX2luY19pdmVyc2lvbihkaXIpOw0KPiAgCWRpci0+aV9tdGltZSA9IGRp
ci0+aV9hdGltZSA9IGN1cnJlbnRfdGltZShkaXIpOyBAQCAtODQ2LDcgKzg0NCw2IEBAIA0KPiBz
dGF0aWMgaW50IGV4ZmF0X21rZGlyKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywg
c3RydWN0IGlub2RlICpkaXIsDQo+ICAJZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eShzYik7DQo+ICAJ
ZXJyID0gZXhmYXRfYWRkX2VudHJ5KGRpciwgZGVudHJ5LT5kX25hbWUubmFtZSwgJmNkaXIsIFRZ
UEVfRElSLA0KPiAgCQkmaW5mbyk7DQo+IC0JZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5KHNiKTsN
Cj4gIAlpZiAoZXJyKQ0KPiAgCQlnb3RvIHVubG9jazsNCj4gDQo+IEBAIC05NzYsNyArOTczLDYg
QEAgc3RhdGljIGludCBleGZhdF9ybWRpcihzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRy
eSAqZGVudHJ5KQ0KPiAgCQlnb3RvIHVubG9jazsNCj4gIAl9DQo+ICAJZWktPmRpci5kaXIgPSBE
SVJfREVMRVRFRDsNCj4gLQlleGZhdF9jbGVhcl92b2x1bWVfZGlydHkoc2IpOw0KPiANCj4gIAlp
bm9kZV9pbmNfaXZlcnNpb24oZGlyKTsNCj4gIAlkaXItPmlfbXRpbWUgPSBkaXItPmlfYXRpbWUg
PSBjdXJyZW50X3RpbWUoZGlyKTsgQEAgLTEzMTEsNyArMTMwNyw2IA0KPiBAQCBzdGF0aWMgaW50
IF9fZXhmYXRfcmVuYW1lKHN0cnVjdCBpbm9kZSAqb2xkX3BhcmVudF9pbm9kZSwNCj4gIAkJICov
DQo+ICAJCW5ld19laS0+ZGlyLmRpciA9IERJUl9ERUxFVEVEOw0KPiAgCX0NCj4gLQlleGZhdF9j
bGVhcl92b2x1bWVfZGlydHkoc2IpOw0KPiAgb3V0Og0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+
IGRpZmYgLS1naXQgYS9mcy9leGZhdC9zdXBlci5jIGIvZnMvZXhmYXQvc3VwZXIuYyBpbmRleCAN
Cj4gOGM5ZmI3ZGNlYzE2Li5jMWY3ZjdiN2M0YWIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2V4ZmF0L3N1
cGVyLmMNCj4gKysrIGIvZnMvZXhmYXQvc3VwZXIuYw0KPiBAQCAtMTAwLDcgKzEwMCw2IEBAIHN0
YXRpYyBpbnQgZXhmYXRfc2V0X3ZvbF9mbGFncyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNp
Z25lZCBzaG9ydCBuZXdfZmxhZ3MpICB7DQo+ICAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9
IEVYRkFUX1NCKHNiKTsNCj4gIAlzdHJ1Y3QgYm9vdF9zZWN0b3IgKnBfYm9vdCA9IChzdHJ1Y3Qg
Ym9vdF9zZWN0b3IgKilzYmktPmJvb3RfYmgtPmJfZGF0YTsNCj4gLQlib29sIHN5bmM7DQo+IA0K
PiAgCS8qIHJldGFpbiBwZXJzaXN0ZW50LWZsYWdzICovDQo+ICAJbmV3X2ZsYWdzIHw9IHNiaS0+
dm9sX2ZsYWdzX3BlcnNpc3RlbnQ7IEBAIC0xMTksMTYgKzExOCwxMSBAQCBzdGF0aWMgDQo+IGlu
dCBleGZhdF9zZXRfdm9sX2ZsYWdzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIHNo
b3J0IA0KPiBuZXdfZmxhZ3MpDQo+IA0KPiAgCXBfYm9vdC0+dm9sX2ZsYWdzID0gY3B1X3RvX2xl
MTYobmV3X2ZsYWdzKTsNCj4gDQo+IC0JaWYgKChuZXdfZmxhZ3MgJiBWT0xVTUVfRElSVFkpICYm
ICFidWZmZXJfZGlydHkoc2JpLT5ib290X2JoKSkNCj4gLQkJc3luYyA9IHRydWU7DQo+IC0JZWxz
ZQ0KPiAtCQlzeW5jID0gZmFsc2U7DQo+IC0NCj4gIAlzZXRfYnVmZmVyX3VwdG9kYXRlKHNiaS0+
Ym9vdF9iaCk7DQo+ICAJbWFya19idWZmZXJfZGlydHkoc2JpLT5ib290X2JoKTsNCj4gDQo+IC0J
aWYgKHN5bmMpDQo+IC0JCXN5bmNfZGlydHlfYnVmZmVyKHNiaS0+Ym9vdF9iaCk7DQo+ICsJX19z
eW5jX2RpcnR5X2J1ZmZlcihzYmktPmJvb3RfYmgsIFJFUV9TWU5DIHwgUkVRX0ZVQSB8IA0KPiAr
UkVRX1BSRUZMVVNIKTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KDQpMb29rcyBnb29kLg0K
DQpCUi4NClQuS29oYWRhDQo=
