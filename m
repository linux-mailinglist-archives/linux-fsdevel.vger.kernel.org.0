Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0F504DFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiDRIlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiDRIlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:41:50 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CED19C13;
        Mon, 18 Apr 2022 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650271152; x=1681807152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WW5LyLt2IQ1lWXI+rRrr7wPaJdak9GXo4XlGbFoOwGY=;
  b=HcUOUoRG74oMCaE4QCVCCd15IQp0HIYTfdGOQxk6Vc2n4lqKZVkV2pQO
   oANlCo9sO5g+7zPZUh3XqUm5QDoZAsJtJpgIPZMfCsJ91Bzk4AsqEkGkO
   AZL/HpSn0xRlqZUno/ctjO2MKz6YiQJvG0c48kZDk0du/fkaAKygiMHAi
   5z3tUUq66VZov9+aHnbJE0Hl/KSrgWreyO3cANOZHcCy6rc1m6lcVfkUg
   1JLyjmCTjk/Cd3fZPBWH/5WrasbJdmnG1/Ay+RTieNj6eNpV6Z3xIE3yr
   5TBTltHBBjxqG583RyyolPuTS2S3qFh72buF1xCwKFXgADcj31LLzVkeC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="54147800"
X-IronPort-AV: E=Sophos;i="5.90,269,1643641200"; 
   d="scan'208";a="54147800"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:39:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu5XP6dyoytBYwY+dPdTJaDU4uUuvzB0qPPswNWYKHbVBzsPmAkulhVhLMbxUXFRA+m9puzliGIkeyLUSRYWpqZWoi6L+Gh/tWQhDA4KtakSCY2uvLbwbUFtJmqpxttRLC7D5NsXGcmIm5yDqH+Jtw4yde7axF5AZCX9dgr4qEeBQ9uCy8T8rr743Oj8kHnv38rZEt8o5TpTWylZIvExSDbfnRRwJnt5c+bQMqjaInShZtduPKxp4TLm69xA9UBU9Aqtv6NVInbR50qj9ji9dNZwPm5bgrsFrlP1TzSBDYDFp47/s8dIASWe0Z3G2W2FPPX8LIZg2WJHtbC5LB23VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW5LyLt2IQ1lWXI+rRrr7wPaJdak9GXo4XlGbFoOwGY=;
 b=XHXRZObZmOPw0BwOTE7LMaoZ15PY00HDlupEAiTVgDz44H6fuVFjZ5awt5tzUM0KHQDQ/wIdZmBK1NJj+olVR+4cm6sL/jDW+hEwLkKnWrpkCvahg8c0n+cfsDYBkfLf0iKcmpP0sqBqW32pO2HGHmn1FNsVCwb9MHojUciaLXRYBNQ6EkqIhHRdq7fd+TkJOd8688j0W89D5PJHsjT8QXPc+2QW+P1h02QHycuh1xQK00u/4DECdW136OSyI65SeLaDzuYksf+Z4GVo7jjkwEhwywCDU/UCsHKrCwMMKXjlwElSES351UtGGot7ffwDr2lL0yigVWMFjv/LKNsC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW5LyLt2IQ1lWXI+rRrr7wPaJdak9GXo4XlGbFoOwGY=;
 b=G6OzCZiipc5eNkjDrX5hDtJ6eNXqo9vaCldUrRfPE3KKRl5KYEcyyGcDjceuCPUXuu35umg5ecY6KoED9iGEwdiuR87Sjm6hCU+ZfVZ6G5als+2KklcbFq3Z1Sgw7W3HRGwW68zONcd2oG+1VkP12NqLkbSLI2uglMZH/T6AySk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB10097.jpnprd01.prod.outlook.com (2603:1096:400:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 08:39:04 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 08:39:04 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christian Brauner <brauner@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v3 1/7] fs/inode: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Topic: [PATCH v3 1/7] fs/inode: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Index: AQHYUK/jJkL7Z7ciH0Owe804/6Pum6zxA3EAgAP+cYCAAG1aAA==
Date:   Mon, 18 Apr 2022 08:39:04 +0000
Message-ID: <625D31FE.9030706@fujitsu.com>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220415140924.oirar6dklelujnxs@wittgenstein>
 <YlzWQyF5e14/UVDs@casper.infradead.org>
In-Reply-To: <YlzWQyF5e14/UVDs@casper.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57d2b310-2a18-49af-38be-08da2116e52e
x-ms-traffictypediagnostic: TYWPR01MB10097:EE_
x-microsoft-antispam-prvs: <TYWPR01MB100970FAC60F26BFFBA429050FDF39@TYWPR01MB10097.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XuHbJdObhQDUskwqg/1b58n0T1WuLF24f7eCgk/U3SlKjdhBI2PanUAsrQkhEMg3qxKILXjsR8uF0nO13336n8D+J0jRluC055cRb41nmGsTqNWmpsPZleh6PPPkq4YoHOh631ZK/JVa2mtQ42UAPTz9pOosAshDhvVuI2qx7iYCuC0TYRTe89a7k/QfaUvZqqQqEeVmmhP4gcpIzjiBpv6F5LKBq0CVWuOQgSer7jwdId0TOdgJlKloBGW28vnUHyk5Oa4N4tC7a/ekbND/p2/KMo+y4UTIoMvUAQenDkALb1fDVetiMv/urkmFqWQIklza3lLlw0G1dCc3OF8lthQtffZzLbsnqzqpteBtmqBJtVJr/w9iIQzPUmYn81ASace5ov/NWL6qeTFwaMs0DaYGAzMyKSFHFwy0bAyfV/cv3pMX6ppW5ox4K+wxNOFBkHJ74KLFHGZlz9hZ++9xhtsLmutVI+r8SiJhzMvlfhOItae8S92XFfcPCm3iC7Q7CFNzGCbdkT7+pe1lNGB2Rth3CV8zkPpZk296xAYVXTlgE9aYc+la4JnhK+rHIlYRskZ/PYObOYkLmO3/8RoBrp7vk3sjgOQJ7v1PiaV5hyZ99sn3cBNX2QN1ztx8UeCkDd5t497F3N1gyW0WuDKE2Bc2yOdRbLQzjS90O5AK5h8ICMLhkdHJGZldJ8Rzd0GXwRas1oobbt5ZnKXjaNeJdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(91956017)(64756008)(71200400001)(66446008)(26005)(508600001)(8676002)(4326008)(6916009)(6486002)(54906003)(36756003)(85182001)(33656002)(86362001)(87266011)(6506007)(6512007)(316002)(186003)(2616005)(83380400001)(2906002)(66476007)(82960400001)(122000001)(66556008)(66946007)(5660300002)(8936002)(7416002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bE5OSEFFT3d1RHFUZ2I1bzlQd3lIL2RwTjYxc281eE9mbk1JTlVHUFQ1WXJt?=
 =?gb2312?B?Y0xOQjZXYnF5MjVTR0lXVlplL1ZrWkdNdXYxd2ZUWU13VHBjTldRdVpUWHlY?=
 =?gb2312?B?VFVETEE5c2FwYVFwN2pKUmdLdHQ4bStxTVFva0VhbXVjbkpMdkR4TG1pZHBG?=
 =?gb2312?B?Y2NkVG53OUQ0SHF6b3pKNmIwVnhueFJoSjRqaXc5Q1JMZ0FtK2x6eXV6ZlJY?=
 =?gb2312?B?VzFIT0I2VFY3cjhQRHgzVUxldUNrdWhxdE8rQmxEYkhkWGM4M042OEwxUUFo?=
 =?gb2312?B?SzJyWk5KclRvMGd0elhWZThXZnpQTUlId25BT2N5Z0pXL016OFVKb2xBQnI1?=
 =?gb2312?B?Zy9rMjI5NkhDR0FkdFU0L2RjNVU5RzNEQmRtMWIrV3BJM0VTUEIwaXp5U094?=
 =?gb2312?B?VSs3NDJ2TUtiS0FQYUcrRlBKbGZlMVJlTXI0ejVWYlVxdVI0U2xlcXd4Sk9S?=
 =?gb2312?B?eXRxYVhseiswaW5hMzB6SkdjNTUzU05sWkFqdkkxVzVUZndRaWd3TjlnUnli?=
 =?gb2312?B?Y1BoWXl5NU1YaWZKWlBkYnBLVXZpOUhOMXVwYmxBZnlzOTdBcTcwakN4QXM4?=
 =?gb2312?B?cU5ySzB4OGZKOUM3WVh1Yi8wUmgwMEh5NGlFc2VISnRZLzNDYzR5MjRKOVZr?=
 =?gb2312?B?N0FjeGxxb011eTdKZEYrUXVGVVBWWUQ5bVBmNWI3dW5tbWJkNit4WGk0V0dr?=
 =?gb2312?B?QmoySGF5czhleDNVTzlscGE0aWZudXkrNzJ4NlE4THZHMUVpZHFZajlobzht?=
 =?gb2312?B?dVZDci9jYUVRNGxrRFJTNUQrTU91YlpKSlI4SkZVaHhqbHNKeUlBT0Y4ZHRY?=
 =?gb2312?B?cXlBT3JFOXJoQXhyRTJmSTd3cVdJWFVZc1FuNUxqWTZEaENrclhQblNkN1h5?=
 =?gb2312?B?Qi9ZWWtLWVR6WmV1QUlYLzU5WGpFdFVTVGRiY2VJSHQ3cDA5T1NBQ1Q4aVFZ?=
 =?gb2312?B?MFpXaEZPZHB1ckNkRGJNSUJ0UmtCTTNxZVkyWUNhbnhmTGFuMHZkNk11MUwx?=
 =?gb2312?B?MXZGZS9HUFlNdnNnTEpTZ2p4Z1Ruek5uSStHaGtZM1V5Y01TN01lajBFZWhT?=
 =?gb2312?B?NmlQU1dVeXJLSEtvOWRRV1JtT2IwT1NWRGxkOXk4ZGkwVE1vQ3J4TFpsZm41?=
 =?gb2312?B?VHFxd3J6b0p1cCtOYVpGMUxJWnptQklqeDBBZEtVUDZFNjliTFNZamFxa0Q0?=
 =?gb2312?B?S0N2RzVaRkNlYnJ6alZaalpSZEVxajVRZTNBWUlObjRtT1M4eDdvemFmdTBT?=
 =?gb2312?B?RHg4VnNUMlJQLzhYV0hBTTNibk1QMDdiNGtzZUk2MW5WVUtTMERZWFhLUCtn?=
 =?gb2312?B?QTl5WjZueWtKREd1OENDMVJJOFJMckYzOGR2SW1SeUNGT0N6MUp4Uml0NnBN?=
 =?gb2312?B?NW51Q1ZyOXRWUjErSWxNWXoxNzVyRFZCbFJiU1RLTHM5RXVlaXVOMWNYT3RT?=
 =?gb2312?B?VC9xOFZWQnlEbmtVRTNUemtOVHBSSk1PWGk0NVpBSmFDL096dm5RTS9wd3VP?=
 =?gb2312?B?RTUydDE4V0J6NTZmV0M3VDFxTmZINDFnNjY3VWZDVTVZaTI4RnZWSHkxZnFY?=
 =?gb2312?B?QndhSHZ1VVl5UDdTbUF4ckV3WHc1bVQraVJuTmRpSlorMXdPUFU4RkEyVTly?=
 =?gb2312?B?L0NCRGN3bXhXUndEc053MkwxaHBYZGRXMTI0N0hUa1N1cUszSU5XMDBrMG5S?=
 =?gb2312?B?R3pSWHVWeUFZNGZHYnpFbGNNcytNMTFRa3Z5bTdOTjRhZnQxRVc2c3hBWmVl?=
 =?gb2312?B?RDlOUVN3SDJBTjRjSEUzeHVudzVpR3dscllHOEcveDVKcERqR3lUMU1JclU1?=
 =?gb2312?B?QnYwQkdPdTFEMStLem9WRjRUeXU5MDUzTzJORWRtWktxTGUrOEhoYnMxTldS?=
 =?gb2312?B?S1pkcit6K1ZqQytzNXd4dEwwSnZkWDloK2hTZlF1WE5tcnN4NXFLaWFDNk1F?=
 =?gb2312?B?eWhTT05oNExyNTZTdlFNY0JWQVg3OVJlYkxVY0pxM3BkQVFJZzZPRDUxZXNw?=
 =?gb2312?B?S25IbUNOdnFhTFdtRVRtUWhhVUJqVUczdFBVUkwzc2dsVEZ3RVZvbmd3ODRC?=
 =?gb2312?B?WXFQelBhNTBCUGRRSnNFQURVTmhUcUhMRnhMblN6eTBGZmRjbHJOZFBjaVBH?=
 =?gb2312?B?VEFsQVFEZitRZzNwNkl4SFZMVTJUSFl4ZlRESUlqdkdWNFc2MVQ2QUIzSTgy?=
 =?gb2312?B?THBjMGZEY3pVdmxCRUpMbGtqTVJURjlNU1NwTHZDZm1nYTFPaEJibXZvMWhQ?=
 =?gb2312?B?S2w0UkI4WGFLMk9NOVFNOW9LYzh2TldFdjVoRTVILzB4U2dTVk5jZUdyV0FL?=
 =?gb2312?B?eUUwZUdLbjJoWk1aMjkvNHRweEhVbjRyckVJT0x5OWNtaW9wUWc4YUZzNnNT?=
 =?gb2312?Q?VcIZhGqGlNoE5XHn6L2ndz3cnEvUjqWFqlzcf?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <1077B7C69E1F38448BDC638CC889163C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d2b310-2a18-49af-38be-08da2116e52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 08:39:04.1230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UI6IztnPMcefjSrRaghuzSvkBhOPTuzezFmR6P/Q2WbH3Qc5IlK+BjfcR+EtkELg5be/u7bDqW9HcBiP8vLACX+CuERwObSImxq6qHHMtvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10097
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE4IDExOjA4LCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gT24gRnJpLCBBcHIg
MTUsIDIwMjIgYXQgMDQ6MDk6MjRQTSArMDIwMCwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+
Pj4gKwkJCWlub2RlX3NnaWRfc3RyaXAobW50X3VzZXJucywgZGlyLCZtb2RlKTsNCj4+PiAgIAl9
IGVsc2UNCj4+PiAgIAkJaW5vZGVfZnNnaWRfc2V0KGlub2RlLCBtbnRfdXNlcm5zKTsNCj4+PiAg
IAlpbm9kZS0+aV9tb2RlID0gbW9kZTsNCj4+PiBAQCAtMjQwNSwzICsyNDAzLDIxIEBAIHN0cnVj
dCB0aW1lc3BlYzY0IGN1cnJlbnRfdGltZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPj4+ICAgCXJl
dHVybiB0aW1lc3RhbXBfdHJ1bmNhdGUobm93LCBpbm9kZSk7DQo+Pj4gICB9DQo+Pj4gICBFWFBP
UlRfU1lNQk9MKGN1cnJlbnRfdGltZSk7DQo+Pj4gKw0KPj4+ICt2b2lkIGlub2RlX3NnaWRfc3Ry
aXAoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLA0KPj4+ICsJCSAgICAgIGNvbnN0
IHN0cnVjdCBpbm9kZSAqZGlyLCB1bW9kZV90ICptb2RlKQ0KPj4+ICt7DQo+Pj4gKwlpZiAoIWRp
ciB8fCAhKGRpci0+aV9tb2RlJiAgU19JU0dJRCkpDQo+Pj4gKwkJcmV0dXJuOw0KPj4+ICsJaWYg
KCgqbW9kZSYgIChTX0lTR0lEIHwgU19JWEdSUCkpICE9IChTX0lTR0lEIHwgU19JWEdSUCkpDQo+
Pj4gKwkJcmV0dXJuOw0KPj4+ICsJaWYgKFNfSVNESVIoKm1vZGUpKQ0KPj4+ICsJCXJldHVybjsN
Cj4+DQo+PiBJJ2QgcGxhY2UgdGhhdCBjaGVjayBmaXJzdCBhcyB0aGlzIHdob2xlIGZ1bmN0aW9u
IGlzIHJlYWxseSBvbmx5DQo+PiByZWxldmFudCBmb3Igbm9uLWRpcmVjdG9yaWVzLg0KPj4NCj4+
IE90aGVyd2lzZSBJIGNhbiBsaXZlIHdpdGggKm1vZGUgYmVpbmcgYSBwb2ludGVyIGFsdGhvdWdo
IEkgc3RpbGwgZmluZA0KPj4gdGhpcyB1bnBsZWFzYW50IEFQSSB3aXNlIGJ1dCB0aGUgYmlrZXNo
ZWQgZG9lcyBpdCdzIGpvYiB3aXRob3V0IGhhdmluZw0KPj4gbXkgY29sb3IuIDopDQo+DQo+IE5v
LCBJIHRoaW5rIHlvdXIgaW5zdGluY3RzIGFyZSBjb3JyZWN0LiAgVGhpcyBzaG91bGQgYmUNCkkg
Y2FuJ3QgdW5kZXJzdGFuZCB3aHkgcmV0dXJuaW5nIHVtb2RlX3QgaXMgYmV0dGVyLiBTbyBEb2Vz
IGtlcm5lbCBoYXZlIA0Kc29tZSBydWxlcyBmb3IgYWRkaW5nIG5ldyBmdW5jdGlvbiBJIGRvbid0
IG5vdGljZSBiZWZvcmU/IEp1c3QgbmVlZCBhIA0KcmVhc29uLg0KDQpwczogSSB3aWxsIGRlY2lk
ZSB3aGV0aGVyIHVzZSBwb2ludGVyIG9yIHVzZSByZXR1cm4gdW1vZGVfdCB2YWx1ZSBiZWZvcmUg
DQpJIHNlbmQgdjQuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPg0KPiB1bW9kZV90IGlub2Rl
X3NnaWRfc3RyaXAoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLA0KPiAJCWNvbnN0
IHN0cnVjdCBpbm9kZSAqZGlyLCB1bW9kZV90IG1vZGUpDQo+IHsNCj4gCWlmIChTX0lTRElSKG1v
ZGUpIHx8ICFkaXIgfHwgIShkaXItPmlfbW9kZSYgIFNfSVNHSUQpKQ0KPiAJCXJldHVybiBtb2Rl
Ow0KPiAJaWYgKG1vZGUmICAoU19JU0dJRCB8IFNfSVhHUlApICE9IChTX0lTR0lEIHwgU19JWEdS
UCkpDQo+IAkJcmV0dXJuIG1vZGU7DQo+IC4uLg0KPg0KPiBhbmQgdGhlIHNhbWUgZm9yIHByZXBh
cmVfbW9kZSgpLg0KPg0KPiBBbmQgcmVhbGx5LCBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIGNhbGxl
ZCBpbm9kZV9zdHJpcF9zZ2lkKCkuICBSaWdodD8NCg==
