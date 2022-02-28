Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6A4C63D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 08:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiB1Hel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 02:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiB1Hej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:34:39 -0500
X-Greylist: delayed 1172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 23:34:00 PST
Received: from mx05.melco.co.jp (mx05.melco.co.jp [192.218.140.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5EC64DD;
        Sun, 27 Feb 2022 23:34:00 -0800 (PST)
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 4K6WpV1qTzzMwjDM;
        Mon, 28 Feb 2022 16:14:26 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 4K6WpV1QjXzMrrNn;
        Mon, 28 Feb 2022 16:14:26 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr05.melco.co.jp (Postfix) with ESMTP id 4K6WpV169FzMvxdF;
        Mon, 28 Feb 2022 16:14:26 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 4K6WpV144JzMr4nD;
        Mon, 28 Feb 2022 16:14:26 +0900 (JST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (unknown [104.47.23.168])
        by mf04.melco.co.jp (Postfix) with ESMTP id 4K6WpV0tGbzMr4nB;
        Mon, 28 Feb 2022 16:14:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6uj2S4Kl6hLGA29509MtUw5klhwnQdL+dfq0z6o1oU6/0dB+cMJOGKaFLZYL7FNkcSLZBj+rZ6iIHwIJm0VqPytcb5+0egXc5D2N8sEXT1kYRYQvxDyJufDWaxVQjU64MTn8lYD5nKZ+LNAh2F2lYlkJuhfHIUX5x3Fnypd/0RjjU4uGo8jgFh9FWu91IXTkjV1/OUKzrPwIF1ks/MIl4op3KZCFatwnkIScUNwtlv7dBuW9EPItYM1O1JMmuXt/j8vz/U18cuJqWYb8/cp6NLjRh7MvpHG9RiTHkcQBy4Wc7bBvkTwzZtVZZZRJl1x+6ujnO2IWeOWnwOicH2vLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdDKR2mEvEHMqdPZdlDBJyJaplzaX6e6f2ZuZnm0faw=;
 b=ZErOOAnjAU8/JsvBVAehFT2CH7wXGYRRmfbXB0b9zPdBJIkRLylEUaKoV9hllrrVy+xLJnloRfIbWrEOrNkQNUUi2Yx83bTX6Ja8R2D/7VlocEI8zBibzxqJRFD80ruS+em85n3qzwCNL9JKh8OVBzwJWzlnsduhFI5rFGwdSZYrpvJFcJUEYu8hE0lafXx7bZaHCfxp4spb8zhHAye+/ahsvG60el6OO3c4N4ThAkKcI2OzmpEfe5a1fhBLleeuwGslr/EFSNzA/LIw1XlSN4INtlVG6bdqVQiNyzX1SA7iWukgs3Yf9vpdJTGQZbC7BMhPhGkgdZpryoHXusmEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdDKR2mEvEHMqdPZdlDBJyJaplzaX6e6f2ZuZnm0faw=;
 b=nOG06U2qVylvJWLcy/9Xf6Oc02UfwbcrVhtn2LrC81mmnH6pAeCW6SWfds/CtZAV5plmTA7t7dl2LWy+AKFJ2BVziHkfblrbaJaT6wFTCLmT+RRrnYvvI8DbKDCkEOZwhKhLCgDlUbpQcz+O4EWKYsGZbNgPLxGwruq9kRGITms=
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8)
 by OSZPR01MB8530.jpnprd01.prod.outlook.com (2603:1096:604:18b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 07:14:25 +0000
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818]) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818%7]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 07:14:25 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "'Yuezhang.Mo@sony.com'" <Yuezhang.Mo@sony.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCayoqY+A
Date:   Mon, 28 Feb 2022 07:11:34 +0000
Deferred-Delivery: Mon, 28 Feb 2022 07:14:00 +0000
Message-ID: <TYAPR01MB5353E089F4843C6CE6A0BA1E90019@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dc.MitsubishiElectric.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96891264-64db-43eb-3982-08d9fa89f3a4
x-ms-traffictypediagnostic: OSZPR01MB8530:EE_
x-microsoft-antispam-prvs: <OSZPR01MB8530A7AA6F331EE96F4A8E5790019@OSZPR01MB8530.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2a4pALoWTMPifuWp8cAy92G1b2URndml8O0vcvDXXEa+C1U/5yrqJdoWmWVT7x6ioeCP9ymHuuXJjcSI4eouxL2UqUMxtjNPNZhxZZ7Ll1wcBjd3QG5T7ZRWtbfKI+rp+BjKHJFAl7jn1HNJ7jyOZKeQ2g3j1Gq05eEbwzsRW3E9Ed623a5RO1S/2MKVbweKRM+HXbbGzmWgHRggy+WrNb7oMvgHD6Kj21VmRZckBYaM6gWfInM2ei2z9Wr/jNHYxA38WiSaclTAt6DmwT4+N8IMmr/NVDhsPKTRwRMM+e1XOQGezvu+HO+DMWUXosClELEz2g+DQsSO7LWjWxo8+0Z5JD6Gir15FEucr+VR5EC27ccUd6blgkWlIlb8iDfs/TzVxyB2ZzD2nwLW+Ni6tpQ75761thuO384oGLwnhB7PF8oF/ZBn4Bf4xC9Hq1aHqqViNTUoGZzsOJgSqqTSx7hNf13aAw0e3MCTxtUJ+ST6i/5q/OZ1DlXSL/Sm77R4GGeEtukGWyKazZ0cWej+tWQ5y8zfmLv0/ied1OsZGUc/rpjc/WMq3suA5w6k4FF1Mk9JprnBTHy9LpebrvWBcSlagDCFnHe+nQaSTWjt2dreFmBMnD2iyBBtm+M2+r67xW+O2U1aFzRx6TJShpgFCWdadCfEFofUO7lxeAzgL96C6FKyBGVpa/vh8WcVbwww9LC4K8Hd8RR/TNeL6UgdF106USEa4qfV8Kcq9hlxALNVYGg6n4h6Cc0GV34Y284
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5353.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(33656002)(4326008)(316002)(55016003)(66446008)(66476007)(186003)(64756008)(508600001)(8676002)(54906003)(66946007)(110136005)(66556008)(7696005)(9686003)(122000001)(71200400001)(86362001)(76116006)(2906002)(38100700002)(38070700005)(52536014)(83380400001)(4744005)(5660300002)(8936002)(6666004)(26005)(95630200002)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?T1hka29GY2JLYi96TkdLR2MxQWFyWjRPZWd5U3hoL21LeHl0aVVEZ2h1?=
 =?iso-2022-jp?B?Z2JBd1BVd00rN2VSdUJtTUJtOHV0N080TGZpSUlGbElqNWxvTnNTQ3k4?=
 =?iso-2022-jp?B?YnBiSmJqRUNSL0tudWh2a3FML2pxd1VmQVh6SHFOemxpUUFjWmZta2pG?=
 =?iso-2022-jp?B?bzQyWXBaVnFKTDFZNmxxbEhLZTV1WStQeVk2bHIxRmEvTTJuRHlIVEZS?=
 =?iso-2022-jp?B?cWRFbkNwcEwxSGh3ZlVlbGZMc2MrMnhxTzdoK1dIb3ZKejFiczVyNk5k?=
 =?iso-2022-jp?B?OGN0aVlqcUpzOE5EakorT3o2Y0tLWDAySE9UUjFWR0hNR2JmVUtQT2JC?=
 =?iso-2022-jp?B?a1pKWlJIUjhsL1dkeTFNdVZwODFEWThLZmQ1aEFmUkQ0WG8xelEzT0dn?=
 =?iso-2022-jp?B?QWRHWXJNYi8wMGo0SWtZZXlnMFFDcm1DVERXc0xUcFA5SDl5OVRJU2R6?=
 =?iso-2022-jp?B?TFVmWk9odHRoTmRyMlNXMnIzOSt4a0xMTWZHWEo4ZDJqQzlBSDk3RGtW?=
 =?iso-2022-jp?B?Rm1DenE2cmprMXJVNGliYTl4VHpQVW1ndEJyZGxMZE1iVVg5R1lrN0NZ?=
 =?iso-2022-jp?B?UzVNdnFLdHRHa21XSFB6NFJveFlpTTBhbUJhTlRmdU8zNVNHNzJpRDd6?=
 =?iso-2022-jp?B?aU5leUR4aXpkckZaSEh2dkhudUdFdTM0U2RWU09qL2pBMko5WW9UbHBX?=
 =?iso-2022-jp?B?N3pmVUliMWJHVno3Qm9TcFE3TkFpdWU2UXd2TDZqMldaWGMzVUJ4cWFv?=
 =?iso-2022-jp?B?WVZQYitxSnZNMTM1OFV3YXBGOXUwUGJlWVNkNndCOGd1YmsxRjlnY3Jn?=
 =?iso-2022-jp?B?SnhnQ3k3UE40cld2K2RSSFZYaWZFUWhrc01VaWQ4K3VDMWNha3hES2hP?=
 =?iso-2022-jp?B?QUJqaWJOeGR6M3cyaVhSOW9kM1NOTjUwSGMxUnF4TFMvczgrbHFYQzdI?=
 =?iso-2022-jp?B?MDFGSlNwNUtNb0dGMytIWTNGd25NZWpScmVRSlFDUzF3c21YMWE4N1la?=
 =?iso-2022-jp?B?WE5DUGY3emtrMEt6a3p6ZUgrQlMybnhqUjVQT2V2VUhDdkpud1h2OUla?=
 =?iso-2022-jp?B?ajIxQTc4R2JiYThpUGIwMDIxUHVhUllrWmY1MnNnWGc3Qk1xWGJhNDYw?=
 =?iso-2022-jp?B?N1BEVUVBdDZaRmdldXBWemtoaU41TVZUYUVScUZOMi84TndRT0FHYURk?=
 =?iso-2022-jp?B?djcxUHdpckZoRXN0bE96bzZqQWhTd21CWVN5dXBSQUxpM0Y3VG9FbUlM?=
 =?iso-2022-jp?B?U1RIalIyamJrcnliMGJOUGRwOU9TTHZMZ0dhV0h3TkY3dU41alBkSGl5?=
 =?iso-2022-jp?B?Wk5Mb0pZai9jN3BoNUI4VHJRZno5RjdkNWh2MVUwQ3cxcjFCa1VSVitn?=
 =?iso-2022-jp?B?M2NPYVRqaWpsWS9pbXE1YmRiekpzM3JVcGd4eWMrWWhZVnNmTmtMbGdq?=
 =?iso-2022-jp?B?UEFKVVEwNmpqUWVtbjY4ZzRGMXB6TjhYTWxETGVnQVRvLzhDd1lyRDhi?=
 =?iso-2022-jp?B?Zm5mZXVwRlZwTXZWVFpuTUpMeTBwWjlwN09vRWhUc3ZhN3hqak9hUWdr?=
 =?iso-2022-jp?B?dm9DVlYxdTVvZVhhdzg3KzRrbzhSRG9mMUZzY1JnMi9LS2dYVG9IUVBm?=
 =?iso-2022-jp?B?a29uMHkrV2lKbUo1N3Z5Skthczd3NzIyUG9KNnJGR2ZkQ2ZiaWJHMmdr?=
 =?iso-2022-jp?B?MnpUc1FhVExhR2hpeU1CT2d0bVZ0RXJSbFlIdWtXSjFQV2ROUWNqOGVZ?=
 =?iso-2022-jp?B?cmpFT21XekJDVFR1UDVoQXdqaU14aTV1RU5YaE9Zc0JxZURlZHNPQ28z?=
 =?iso-2022-jp?B?VlczNzE0eDBnTTN6aUZuVmhSK3JXdXlhS01qeWt0T1pPWkZWaStnYUNY?=
 =?iso-2022-jp?B?SXRXWVJPVDNDNlZ5ZzNKT3NUSEU3MU1Hd2ZZR3ppTkhoNjFaN0l4N3li?=
 =?iso-2022-jp?B?TnVVTFBIalhkNFZ2VHFlSDIrWGc1MENtUzlsVFpSdWp0VWo0NmF3VkZy?=
 =?iso-2022-jp?B?VUJYa1doeFpNaUV0a2pkU2tPbXhNRXp1dUtGalpEaGRLQi96MEZPS3RT?=
 =?iso-2022-jp?B?NHhZbDZ2c25rZW5xa0czVjlVZG5ZUVQwUlZGNU13UjVsOGN5REhZbkFy?=
 =?iso-2022-jp?B?NnNBaWNOeDQ2ajhPQ0xSbWZVUGwvdVhxQllLeTNSb0hPVlQ1QXdvemty?=
 =?iso-2022-jp?B?U29qbllhWXVyVE9zR1kxRi9Penp2Rk42S0hmaG5ZUmFxR0JjTDRRcXZJ?=
 =?iso-2022-jp?B?YURCU0pNelR2dDVxc0JpU214T2ttYk9ub05HaEFVK01LYWp1dVZEUVZF?=
 =?iso-2022-jp?B?ZGU2ckVENjNsbVpJaWdvcDE5Z0EyYnhiVFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5353.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96891264-64db-43eb-3982-08d9fa89f3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 07:14:25.4256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOENMwNAVt/0//NNxIpJ2xE0ASIppKAjvLPxmS99254aQAnTjDik130lT5NLuo1VLhOUFQf81jZ1Jwx/dBh9BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Yuezhang.

> And VolumeDirty will be set again when updating the parent directory. It =
means that BootSector will be written twice in
> each writeback, that will shorten the life of the device.

I have the same concern.
From a lifespan point of view, we should probably clear dirty with just syn=
c_fs().

>  	sync_blockdev(sb->s_bdev);
> -	if (exfat_clear_volume_dirty(sb))
> +	if (__exfat_clear_volume_dirty(sb))

If SB_SYNCHRONOUS or SB_DIRSYNC is not present, isn't dirty cleared?

> +int exfat_clear_volume_dirty(struct super_block *sb) {
> +	if (sb->s_flags & (SB_SYNCHRONOUS | SB_DIRSYNC))
> +		return __exfat_clear_volume_dirty(sb);

Even when only one of SB or DIR is synced, dirty will be cleared.
Isn't it necessary to have both SB_SYNCHRONOUS and SB_DIRSYNC?
And, I think it would be better to use IS_SYNC or IS_DIRSYNC macro here.

BR


