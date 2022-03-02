Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F46E4CA0CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 10:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbiCBJas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 04:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiCBJal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:30:41 -0500
Received: from mx05.melco.co.jp (mx05.melco.co.jp [192.218.140.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC6ABBE35;
        Wed,  2 Mar 2022 01:29:48 -0800 (PST)
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 4K7pjl0sXfzMxFZj;
        Wed,  2 Mar 2022 18:29:47 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 4K7pjl09HfzMvxf3;
        Wed,  2 Mar 2022 18:29:47 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr05.melco.co.jp (Postfix) with ESMTP id 4K7pjk6yQpzMvxf0;
        Wed,  2 Mar 2022 18:29:46 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4K7pjk6wC8z6bMb;
        Wed,  2 Mar 2022 18:29:46 +0900 (JST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (unknown [104.47.23.169])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4K7pjk6nkDzMqcsf;
        Wed,  2 Mar 2022 18:29:46 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBk6byDwi29odHgk2loAzrtPFdI57A5PqC6GO/DRnR7yR+yJS/Oe4RGof73SvZSJg3Ud/7c5yqT9+5QsByw6S+cScJ1eIaD+kqWy9hqWI+KI7QDTIGJ/UjvQoAVgZzcgQ5bmLkstc4PWbiCUNyW1mcwUFlYyD4ARYTrkELiiGvYzR4ZOu8pqaF8lzd8jBuRA6qMUSVNc23X9Qnmpt98zTvc9zuw2pTHn/kdYjinkrBzBFBtdB82OFYeLJyNCclvU8CNdkGC2CDjOEMMvkcD38V0m8dnnj0eAXnzFw2TtaDXiIiX6tKRSr8JdfjjDgW6OWhjjC3ZRx1U8JStL7CYcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kkj2kfyIXmZh9zUeNd+4AryAUv42h/ouOMIvyGXkvxw=;
 b=f1ad41OHgpADCv3v3qNVvUWR2Q//5vjZG2+a+UyeIDmMtN3TnU6b9ZDxU4J4JbNjaGu3EYVm4fLN0iYzlgOGKhfyz480oK5o1oiIjTwFjhIZUMxjo1VyPIupj7nhThuO4OdXho+PqFHMju89d/0/Dv1tTNisFVguxEerP0AFVhxNHMZ8qjJfLA46E1AnsRMJ4D0bSyEIN40KnaUpa5khdvvY3DrIHSdSvaW60iHTu21W97pzZC9xcg1DNO7ynTMb9L1xvYSs+26XLO5jiwLB9h4qEGl+sJ25SzElj75XefL5N2ZeWsbHUxdwLe4xk6aMZWYs0VkXOKOZ+3+0ex/yCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kkj2kfyIXmZh9zUeNd+4AryAUv42h/ouOMIvyGXkvxw=;
 b=S+hUSS4w1BanGxbuIE8Jbsu+pc4vTqikO/tx07wNdfOUvv37qcMfcxAwMm1iwKgBlXG9pxgB7/Zzwt4OOrMtxfuGwcBRLb1OM8+pDtJn/3JXTylKkxeBY4SatjBK9MCEfa1As7qFD7+NT/iGGgS7Bk/SBeDlVHbOtwlURdeYbbc=
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8)
 by TYAPR01MB2093.jpnprd01.prod.outlook.com (2603:1096:404:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 09:29:45 +0000
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818]) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818%7]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 09:29:45 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCayoqY+AgAA/KGCAAw0zDw==
Date:   Wed, 2 Mar 2022 09:29:45 +0000
Message-ID: <TYAPR01MB53531DB8B19324F7D60EE9AA90039@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353E089F4843C6CE6A0BA1E90019@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <HK2PR04MB3891B4F1C2BC707582E81C0C81019@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB3891B4F1C2BC707582E81C0C81019@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: be3a5143-1252-e531-3e92-ba3862775787
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dc.MitsubishiElectric.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcb8df90-b5fe-416b-d63f-08d9fc2f3033
x-ms-traffictypediagnostic: TYAPR01MB2093:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2093639E52BA4C64FC3E4F7990039@TYAPR01MB2093.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q1E9f39uDxwx3BAD4TX+soObLePok06Jlou62PQxbYNdHx1sdnBg4DyttIR149T/8L8g240RHzaeZP39jNNE2OAXj7SyQIWjadtog5svYkv2Dq9ABJVisWxWoFWJg+Wgr+H3dZt8xMD62+F7Zzs5A9aYKZhDvxXdJXh+cJ2lWQbVAv+WVB/DoAjMQPlVHlCHP1jzLqJEwyypgXHh8T28XHxWhY/YX3J96c39P7in1NcIGqDfX3Cr3noJZnchCxddv+FGaiX+Qx54gJRMprBUq8ZLMryqpk6CxYi/KOdjxpXNBvEiQOMFX6pDwHMjl1t7QGDXCS758v9xN35zOyZB2LqP0FKjpIS7zLzBnaC6Lqa2zwXMg4w3Pv96UMvR4sDmHSdaTm5AODgn1zpVjNIwO7h9C0pQEcGStHUxS3FY4NCWI19aa1RWxglfkCInJPDbXthJEFI+cSPbh5/tWsc6loQOgCFnbLKMCR3aSrEskBOFng/IPk918tZlyw0lX4Cv/PkHaiDVU453qleEUvjeK1L7mZiGseL1ARI6XTraGtrDfCWyTW72R2jIvCi5h07ZBoJ9TPNfsJc0rJh4Eqp8v7a0qwERJhS8OoIp1h5zQIzTTeEu7HjDIyB7eJhOxTRxeuubVG1Ml08Pyeq24njwDtFUIDfui3lx4yfbsq1rBW5oHocqpoypZqfYesldQqc+NZmPCuZt85GuXk3hVjuvxSesh73BiCLRu71tQZgtc/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5353.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(38100700002)(33656002)(71200400001)(83380400001)(55016003)(508600001)(122000001)(110136005)(54906003)(52536014)(8936002)(9686003)(86362001)(5660300002)(38070700005)(316002)(66446008)(186003)(64756008)(66476007)(66556008)(76116006)(66946007)(8676002)(91956017)(2906002)(4326008)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NU9VS3hNT0pkSDRjVGFiMlNFN3JDVCt6cHpNa2xzQVJvZzc1RjdxUHkx?=
 =?iso-2022-jp?B?Ymhsd1BRbU5Ub2puNFh5eDQ2YzBVdm5qUFg4d0VhcVovZm9IUWVYZFZG?=
 =?iso-2022-jp?B?SVBXZ1dBcU1qeWlvSlljOGhGTXNuKytJOURHTklNcDhZbDNUbzcvU0hD?=
 =?iso-2022-jp?B?Y1dmeHoxaEtST0tBTVNrSnYzWE9XZ0tyZGJMZitSV2J6NkZKUzEyVEFN?=
 =?iso-2022-jp?B?eXg2eDJmNTlLcDRGdWVpcTVrN1Y5SW9XWVErQ3JnRm04QmY4dGEzbGVr?=
 =?iso-2022-jp?B?ZHVzSktLNDA1VFZjSURqZFg4VEJnNnB1Yi9mdzVtR3RxYy9CWVRDVWVu?=
 =?iso-2022-jp?B?RWdYeUZydkpwYzJ1SGlBazIzSDVDVVlKRW82QXNuUXIrRGFIVGNMS1Qz?=
 =?iso-2022-jp?B?dHZ0YWdKcVUyMUwxTHM3b213WGlGL0p3MGtrSnloY2M2dlRuUE9pRUFq?=
 =?iso-2022-jp?B?dm5HalJ4b2lSZzBreVFjeTg4ejlTSzdzcnB6cjdYNkVPbFFPYWFldHdI?=
 =?iso-2022-jp?B?UkhNKytmMEd3ZEN0UUdvWkdjNnJIYlJSekJIWDQ3YXBSd3N0OVlUb2lC?=
 =?iso-2022-jp?B?ZGRjL1FxU2xuTFF5SStXVUFzM0FIekZkbStYN3dEQy9HVlhwRDZ4ZkdX?=
 =?iso-2022-jp?B?TGtIR0w1VGs1Rm9wckFzRkdQcW0vT1dHL0VZWEV6V29pTzFqY21zRzZR?=
 =?iso-2022-jp?B?SEZrMXdjRURFZ0ZWL1RSWWsybGFtSVdtMzBac1NOcVJpWHlISEtGSHAv?=
 =?iso-2022-jp?B?U1dza0x0Q1VMYkhQRElIL0N1bnBQdms2VitvUStEWC9MWjUzNzBlY0Fo?=
 =?iso-2022-jp?B?RE1TR1Q2dm9GdWtqdk5SUTkyWHZGdkQxcHpCQmR4VWduejl4WUtRcmhS?=
 =?iso-2022-jp?B?TURPWG1aN1hNK2ZnVnh1Y3FkdVBuSmJvZVl2NDV1bXNNVDNYay9ja2Vl?=
 =?iso-2022-jp?B?NFJzc2NJbWtSVVVHV0ZYVnVTUzFtL2loVEVmNGk3a2p4S1FnT3l3MmV2?=
 =?iso-2022-jp?B?UkFtclIyQzRFbDdEQzdKWDNVcHd5anZtK1hIdFZwSXVmREQxYXp2Ty9r?=
 =?iso-2022-jp?B?M1ByMUtEWWFKcGRUWE04TTVIOVl4QkZzRllzZWo2MnJuUDNtWmx5Zmk1?=
 =?iso-2022-jp?B?bjdYRWhZZXZlZWVLak83MlhVOWtxdFR6VExhalVoR1lMck5aSm9lbmlm?=
 =?iso-2022-jp?B?ODFVekZoT0cvbXBqRGI5MDVTa2ZZZnpwb2FNZnhsTVZMek5idldoNlhY?=
 =?iso-2022-jp?B?Zi9veWk0NkFkZzQxZnFhenRhNXhYdXpVcU1GdDhUbzNYeFRJWENUOVp4?=
 =?iso-2022-jp?B?OGNPMW8vUDFzSzhsUnhKOTVPQzlSZ21Bc1Y5OElybGF6NVR5OTJ1T3lu?=
 =?iso-2022-jp?B?Z1hjUkRhUW5WZjFxWnVSREU1bG44a05pL2Vzb0k4c3duMnp3cEUrNWFH?=
 =?iso-2022-jp?B?S1JGY3I2eU4yV29LRUhXNVJSalpvSmlCUVJFTGJLc0F1WWI5eXNPUnBY?=
 =?iso-2022-jp?B?R0pwRktPd1ltUHg4VHhLS2NlV3lTb1U4SUlLVDJDdkkyU2JRajdtUW9D?=
 =?iso-2022-jp?B?Ym1uUTdzVEE5MkRuaXlBMlBTcUh2SGlHYnROMWtNWDdxRDJDWDF6OGJp?=
 =?iso-2022-jp?B?RFdCT283NVBaaWFLM3Y1b0RLb3loaVFBR0Q4V3V4c09DaE1ETG5XNlQx?=
 =?iso-2022-jp?B?azQ5dmFyRlJDdXpVZ3NkZ1Fmc1ZEdHUyS0E0SGtUMnIrWHVWU3YvR0xF?=
 =?iso-2022-jp?B?MGlOdUIrMEJBMm1mbDVNMUR6R0ZrbXBURXhvSkJORnFRSFVDNC9OeUpH?=
 =?iso-2022-jp?B?TTZtZ1BPS2M5MGxvaDlRMjUyQmxKN2Z1L3BDOGkwYzBOWWJnUitTY0xR?=
 =?iso-2022-jp?B?d1duYUZZeW5PWThwWVRtM1BiUU1KYzB2Z2RYL08rM3V0aVRmdjkvOThI?=
 =?iso-2022-jp?B?VEpybnFMRHVSWHBNZUM3V21QWVgvWWs4WUoxdGtRNThuajg4TmVjTG11?=
 =?iso-2022-jp?B?K1VrUG5HYkRJZjhGZlFuYnl3aUgyNm1wZlgvNkdGM3lMaC85b0ZpcTdI?=
 =?iso-2022-jp?B?UlNsTGV4WTN4ZnB1blM5ejM5Tk8wdjJWSEF1OG94ekRTTzBxVWpKcWdY?=
 =?iso-2022-jp?B?T2xuNCt5SlVBeTNLMy8yRkgybU1OYTRYRGtzclE5SnNEbzVqWjdFK3lP?=
 =?iso-2022-jp?B?RURTQU5ESDh2dFp1c3dxNXNqMlA2TlF0Q3Q5cmVSRFdKTkV3MmxFVWdX?=
 =?iso-2022-jp?B?MEFPRjVLZiswbVVXVHNSTE1zUnlnaEdLMm1vMmMvc0RneFFOY0JQMENP?=
 =?iso-2022-jp?B?OGNKZHpDL2FDVW5oMW1QeWZZQWMrTjExajB1am9ielhhdmEyOG5LMFBP?=
 =?iso-2022-jp?B?MnQ2NUtFVVoySUs1YllNM0xKbXVlZ1VZc2hqSnF2aXlrNzVqL3MrS3hm?=
 =?iso-2022-jp?B?WkdFdVRRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5353.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb8df90-b5fe-416b-d63f-08d9fc2f3033
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 09:29:45.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNHOW7KhLpJokJjqG2JELaJ9NWNE7nv2mBzPrp8hmkMwQJ8K78ri702SIkEWU3iG+EgdYwyo7o2LKA/U/SHjaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2093
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Yuezhang,Mo=0A=
=0A=
Thank for your comments.=0A=
=0A=
>>> And VolumeDirty will be set again when updating the parent directory. =
=0A=
>>> It means that BootSector will be written twice in each writeback, that =
will shorten the life of the device.=0A=
>> =0A=
>> I have the same concern.=0A=
>> From a lifespan point of view, we should probably clear dirty with just =
sync_fs().=0A=
>=0A=
>If it is acceptable for VolumeDirty to remain dirty after all updates are =
complete, I think it is a good idea.=0A=
=0A=
This patch will keep VOL_DIRTY until sync_fs or umount when default mount.=
=0A=
It's a preferred change for device life and VOL_DIRTY integrity. =0A=
On the other hand, we should think more about the behavior when SB_SYNCHRON=
OUS is set.=0A=
For example, FATFS keep VOL_DIRTY until umount regardless of SB_SYNCHRONOUS=
. =0A=
When SB_SYNCHRONOUS is enabled, updating VOL_DIRTY every time will increase=
 the number of writes to the boot-sector.=0A=
For NAND flash devices, mounts with 'sync' are a dangerous option that can =
drastically wear out their lifespan.=0A=
=0A=
=0A=
>(PS: The original logic is to clear VolumeDirty after BitMap, FAT and dire=
ctory entries are updated.)=0A=
=0A=
However, the writing order was not guaranteed.=0A=
More synchronous writes are needed to guarantee the write order.=0A=
=0A=
=0A=
>>>  	sync_blockdev(sb->s_bdev);=0A=
>>> -	if (exfat_clear_volume_dirty(sb))=0A=
>>> +	if (__exfat_clear_volume_dirty(sb))=0A=
>> =0A=
>> If SB_SYNCHRONOUS or SB_DIRSYNC is not present, isn't dirty cleared?=0A=
>=0A=
>With this patch, exfat_clear_volume_dirty() will not clear VolumeDirty if =
SB_SYNCHRONOUS or SB_DIRSYNC is not present, and __exfat_clear_volume_dirty=
() will clear VolumeDirty unconditionally.=0A=
=0A=
__exfat_clear_volume_dirty() only mark_buffer_dirty() to boot-sector, it do=
esn't sync.=0A=
It should sync in here or exfat_set_vol_flags().=0A=
=0A=
=0A=
>>> +int exfat_clear_volume_dirty(struct super_block *sb) {=0A=
>>> +	if (sb->s_flags & (SB_SYNCHRONOUS | SB_DIRSYNC))=0A=
>>> +		return __exfat_clear_volume_dirty(sb);=0A=
>> =0A=
>> Even when only one of SB or DIR is synced, dirty will be cleared.=0A=
>> Isn't it necessary to have both SB_SYNCHRONOUS and SB_DIRSYNC?=0A=
>=0A=
>VolumeDirty will be cleared if one of SB_SYNCHRONOUS and SB_DIRSYNC is set=
.=0A=
>The condition of (sb->s_flags & (SB_SYNCHRONOUS | SB_DIRSYNC)) is exactly =
that.=0A=
=0A=
Even if dir-entries is synced, dirty must not be cleared when FAT / mirrorF=
AT is not synced.=0A=
Also, it is not necessary to clear VOL_DIRTY even if SB_DIRSYNC is set.=0A=
I don't think it is necessary to check SB_DIRSYNC.=0A=
=0A=
=0A=
>> And, I think it would be better to use IS_SYNC or IS_DIRSYNC macro here.=
=0A=
>=0A=
>If use IS_SYNC or IS_DIRSYNC, we should pass `inode` as an argument, it wi=
ll be a big change for code.=0A=
>And if open a file with O_SYNC, IS_DIRSYNC and IS_SYNC will be true, Volum=
eDirty will be cleared. =0A=
>So I think it is not necessary to use IS_DIRSYNC and IS_SYNC.=0A=
=0A=
exactly.=0A=
=0A=
=0A=
BR=
