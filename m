Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490954CC371
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 18:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiCCRL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 12:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiCCRL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:11:27 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C81795DD;
        Thu,  3 Mar 2022 09:10:38 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220303171033usoutp01fc1da3397015eee4ddf30ba2e822f454~Y7hQMgn9N0042100421usoutp01i;
        Thu,  3 Mar 2022 17:10:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220303171033usoutp01fc1da3397015eee4ddf30ba2e822f454~Y7hQMgn9N0042100421usoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646327433;
        bh=AlMFOfEhiETCOk3XbxzQzXQ4curFsYE/u7bYQUQfueM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ErIwc1n5jzEybZ81WgrV1Jyj7vYsxefRUBQdgfb1FxrGbpPe10I6uhS2E62jGi6nb
         EorZ/HdBkd+q9yYfTVmi9p6ADXJ9lxq3odd1t8V0AOZzjBWpn8V5aB5x+RSgu7aqM6
         HKP65rQfXykZBM1KMA488vodDLbcXt/VGtM9U0r0=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220303171033uscas1p121c205baf46587359e4f6e0cc986f79f~Y7hP6EPX80197601976uscas1p1Z;
        Thu,  3 Mar 2022 17:10:33 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id CE.CE.10104.986F0226; Thu, 
        3 Mar 2022 12:10:33 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220303171032uscas1p235f6966a10b5f8c488f5a9503331b675~Y7hPfjKGx0881108811uscas1p2V;
        Thu,  3 Mar 2022 17:10:32 +0000 (GMT)
X-AuditID: cbfec36f-315ff70000002778-28-6220f6894b97
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 45.E3.10042.886F0226; Thu, 
        3 Mar 2022 12:10:32 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 3 Mar 2022 09:10:31 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Thu, 3 Mar 2022 09:10:25 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmb9dDgbycJL0eB2NODtYgLP6ytqQyAgAAQCACAADetAIAAVbuAgAAHhQCAAB4RAA==
Date:   Thu, 3 Mar 2022 17:10:25 +0000
Message-ID: <20220303171025.GA11082@bgt-140510-bm01>
In-Reply-To: <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <636DDB7C0B5EA941981D1922F14A6B49@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djX87qd3xSSDFpX81tM+/CT2aK1/RuT
        RefpC0wWf7vuMVls23+QzWLvLW2LPXtPsljse72X2WJC21dmixsTnjJaTDy+mdVizc2nLA48
        HpeveHvsnHWX3aN5wR0Wj02rOtk8Jt9YzujxeZOcR/uBbqYA9igum5TUnMyy1CJ9uwSujEO3
        rjMW7EutmDv9LVsD44ekLkZODgkBE4m9TX1MXYxcHEICKxklXu35zQjhtDJJbDmxnw2m6vDS
        51CJtYwSM762QLV8YJQ4vnUlG4Szn1Hi3caPrCAtbAIGEr+Pb2QGsUUEtCSW7XvHClLELNDD
        KrHv2wOgdg4OYQFjiRdb6yFqTCTOvj7KBmGHSWyd8w/MZhFQkfj2eibYHF6gmvV9N8HinALW
        Em9uTgLbxSggJvH91BomEJtZQFzi1pP5TBBnC0osmr2HGcIWk/i36yHUO4oS97+/ZAc5gVlA
        U2L9Ln2IVjuJXV3v2CFsRYkp3Q/ZIdYKSpyc+YQFolVS4uCKGywgr0gIdHNKzHg/lR0i4SLx
        fukxVghbWuLv3WVMEEWrGCWmfGtjh3A2A8Pu1wWo66wl/nVeY5/AqDILyeGzEI6aheSoWUiO
        moXkqAWMrKsYxUuLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECk9zpf4fzdzBev/VR7xAjEwfj
        IUYJDmYlEV5LTYUkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzLMjckCgmkJ5akZqemFqQWwWSZ
        ODilGph2HYlybAliUJulEuN2S8jyr7PAus0cGu5mf09du188M2bWUom8GVtqtITuRse1M9/n
        cKnv3Lo2eGao8dOufqHsnNvBf6a4f1rvOV87OKV72Q6pE7e6Xy9rmeZ0WO+xRoZbOtfyvo2n
        eteuaVvRy39zmmlf0vJfDQ5MQfdvsi28v+bShoKqOVcivKTl73z4/+mUbqKp5ueMmmjHOSls
        YR5SC0REHc7NbIjacEW1lYfZt3fSvTal5E0i4Yd/rZwbvbRt92L3B7GRRuuurnmVwvk8J6FW
        r+uDlsvxb3cszus0iLhteXFf0XxCuMcRE+FJM9yShSx2Hb8klJfakRMyYwvPa0O3qP1tk75r
        3TXU9FBiKc5INNRiLipOBABy3Hgo4QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWS2cA0Sbfjm0KSwalN1hbTPvxktmht/8Zk
        0Xn6ApPF3657TBbb9h9ks9h7S9tiz96TLBb7Xu9ltpjQ9pXZ4saEp4wWE49vZrVYc/MpiwOP
        x+Ur3h47Z91l92hecIfFY9OqTjaPyTeWM3p83iTn0X6gmymAPYrLJiU1J7MstUjfLoEr49Ct
        64wF+1Ir5k5/y9bA+CGpi5GTQ0LAROLw0ueMXYxcHEICqxkl5rzfxQrhfGCUWHp0BzuEs59R
        ovfMNmaQFjYBA4nfxzeC2SICWhLL9r0D62AW6GGV2PftAVMXIweHsICxxIut9RA1JhJnXx9l
        g7DDJLbO+QdmswioSHx7PRNsDi9Qzfq+m2wQy1qYJTpa34IlOAWsJd7cnMQKYjMKiEl8P7WG
        CcRmFhCXuPVkPhPEDwISS/acZ4awRSVePv7HCmErStz//pId5B5mAU2J9bv0IVrtJHZ1vWOH
        sBUlpnQ/ZIe4QVDi5MwnLBCtkhIHV9xgmcAoMQvJtlkIk2YhmTQLyaRZSCYtYGRdxSheWlyc
        m15RbJSXWq5XnJhbXJqXrpecn7uJEZgcTv87HL2D8fatj3qHGJk4GA8xSnAwK4nwWmoqJAnx
        piRWVqUW5ccXleakFh9ilOZgURLnfRk1MV5IID2xJDU7NbUgtQgmy8TBKdXAxKExr5K79lXT
        VJOt8x4y1R8KEjhi9jnuwd6+hXsruOcsyss2FhabJc30I/wCp+z2S1K9uZZRDz98Ndmza8J8
        Pb5ktnt3xZdNuPL52ZaM+mf7He5fW2J+tfb0+9PuT20EF1Y9PSd59EiAfmHSd8cNjnXJtW/P
        ddyaWXrxl3V+taN4ktuKzrqZNdXyVyaekdohMUU1i0urPat339eHkYahJ3ulvrE8VK1p8Jwq
        Hzhh3QS25Yv9Xn0IN88s8r+QwKaw1vFaYir3Dutp9/5rzChMvLDzx42KCbWaMfoXf3L46tSn
        571oym25rfRL8VwM54Jt6zfwnPkdtWl6nde77KV9J0KO8fKHMteYvo62/3B2ixJLcUaioRZz
        UXEiAJK0i0J9AwAA
X-CMS-MailID: 20220303171032uscas1p235f6966a10b5f8c488f5a9503331b675
CMS-TYPE: 301P
X-CMS-RootMailID: 20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
        <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
        <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
        <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
        <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
        <20220303145551.GA7057@bgt-140510-bm01>
        <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCBNYXIgMDMsIDIwMjIgYXQgMDM6MjI6NTJQTSArMDAwMCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6DQo+IE9uIDIwMjIvMDMvMDMgMTY6NTUsIEFkYW0gTWFuemFuYXJlcyB3cm90ZToNCj4g
PiBPbiBUaHUsIE1hciAwMywgMjAyMiBhdCAwOTo0OTowNkFNICswMDAwLCBEYW1pZW4gTGUgTW9h
bCB3cm90ZToNCj4gPj4gT24gMjAyMi8wMy8wMyA4OjI5LCBKYXZpZXIgR29uesOhbGV6IHdyb3Rl
Og0KPiA+Pj4gT24gMDMuMDMuMjAyMiAwNjozMiwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToNCj4g
Pj4+Pg0KPiA+Pj4+PiBPbiAzIE1hciAyMDIyLCBhdCAwNC4yNCwgTHVpcyBDaGFtYmVybGFpbiA8
bWNncm9mQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+PiDvu79UaGlua2luZyBw
cm9hY3RpdmVseSBhYm91dCBMU0ZNTSwgcmVnYXJkaW5nIGp1c3QgWm9uZSBzdG9yYWdlLi4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gSSdkIGxpa2UgdG8gcHJvcG9zZSBhIEJvRiBmb3IgWm9uZWQgU3RvcmFn
ZS4gVGhlIHBvaW50IG9mIGl0IGlzDQo+ID4+Pj4+IHRvIGFkZHJlc3MgdGhlIGV4aXN0aW5nIHBv
aW50IHBvaW50cyB3ZSBoYXZlIGFuZCB0YWtlIGFkdmFudGFnZSBvZg0KPiA+Pj4+PiBoYXZpbmcg
Zm9sa3MgaW4gdGhlIHJvb20gd2UgY2FuIGxpa2VseSBzZXR0bGUgb24gdGhpbmdzIGZhc3RlciB3
aGljaA0KPiA+Pj4+PiBvdGhlcndpc2Ugd291bGQgdGFrZSB5ZWFycy4NCj4gPj4+Pj4NCj4gPj4+
Pj4gSSdsbCB0aHJvdyBhdCBsZWFzdCBvbmUgdG9waWMgb3V0Og0KPiA+Pj4+Pg0KPiA+Pj4+PiAg
KiBSYXcgYWNjZXNzIGZvciB6b25lIGFwcGVuZCBmb3IgbWljcm9iZW5jaG1hcmtzOg0KPiA+Pj4+
PiAgICAgIC0gYXJlIHdlIHJlYWxseSBoYXBweSB3aXRoIHRoZSBzdGF0dXMgcXVvPw0KPiA+Pj4+
PiAgICAtIGlmIG5vdCB3aGF0IG91dGxldHMgZG8gd2UgaGF2ZT8NCj4gPj4+Pj4NCj4gPj4+Pj4g
SSB0aGluayB0aGUgbnZtZSBwYXNzdGhyb2doIHN0dWZmIGRlc2VydmVzIGl0J3Mgb3duIHNoYXJl
ZA0KPiA+Pj4+PiBkaXNjdXNzaW9uIHRob3VnaCBhbmQgc2hvdWxkIG5vdCBtYWtlIGl0IHBhcnQg
b2YgdGhlIEJvRi4NCj4gPj4+Pj4NCj4gPj4+Pj4gIEx1aXMNCj4gPj4+Pg0KPiA+Pj4+IFRoYW5r
cyBmb3IgcHJvcG9zaW5nIHRoaXMsIEx1aXMuDQo+ID4+Pj4NCj4gPj4+PiBJ4oCZZCBsaWtlIHRv
IGpvaW4gdGhpcyBkaXNjdXNzaW9uIHRvby4NCj4gPj4+Pg0KPiA+Pj4+IFRoYW5rcywNCj4gPj4+
PiBKYXZpZXINCj4gPj4+DQo+ID4+PiBMZXQgbWUgZXhwYW5kIGEgYml0IG9uIHRoaXMuIFRoZXJl
IGlzIG9uZSB0b3BpYyB0aGF0IEkgd291bGQgbGlrZSB0bw0KPiA+Pj4gY292ZXIgaW4gdGhpcyBz
ZXNzaW9uOg0KPiA+Pj4NCj4gPj4+ICAgIC0gUE8yIHpvbmUgc2l6ZXMNCj4gPj4+ICAgICAgICBJ
biB0aGUgcGFzdCB3ZWVrcyB3ZSBoYXZlIGJlZW4gdGFsa2luZyB0byBEYW1pZW4gYW5kIE1hdGlh
cyBhcm91bmQNCj4gPj4+ICAgICAgICB0aGUgY29uc3RyYWludCB0aGF0IHdlIGN1cnJlbnRseSBo
YXZlIGZvciBQTzIgem9uZSBzaXplcy4gV2hpbGUNCj4gPj4+ICAgICAgICB0aGlzIGhhcyBub3Qg
YmVlbiBhbiBpc3N1ZSBmb3IgU01SIEhERHMsIHRoZSBnYXAgdGhhdCBaTlMNCj4gPj4+ICAgICAg
ICBpbnRyb2R1Y2VzIGJldHdlZW4gem9uZSBjYXBhY2l0eSBhbmQgem9uZSBzaXplIGNhdXNlcyBo
b2xlcyBpbiB0aGUNCj4gPj4+ICAgICAgICBhZGRyZXNzIHNwYWNlLiBUaGlzIHVubWFwcGVkIExC
QSBzcGFjZSBoYXMgYmVlbiB0aGUgdG9waWMgb2YNCj4gPj4+ICAgICAgICBkaXNjdXNzaW9uIHdp
dGggc2V2ZXJhbCBaTlMgYWRvcHRlcnMuDQo+ID4+Pg0KPiA+Pj4gICAgICAgIE9uZSBvZiB0aGUg
dGhpbmdzIHRvIG5vdGUgaGVyZSBpcyB0aGF0IGV2ZW4gaWYgdGhlIHpvbmUgc2l6ZSBpcyBhDQo+
ID4+PiAgICAgICAgUE8yLCB0aGUgem9uZSBjYXBhY2l0eSBpcyB0eXBpY2FsbHkgbm90LiBUaGlz
IG1lYW5zIHRoYXQgZXZlbiB3aGVuDQo+ID4+PiAgICAgICAgd2UgY2FuIHVzZSBzaGlmdHMgdG8g
bW92ZSBhcm91bmQgem9uZXMsIHRoZSBhY3R1YWwgZGF0YSBwbGFjZW1lbnQNCj4gPj4+ICAgICAg
ICBhbGdvcml0aG1zIG5lZWQgdG8gZGVhbCB3aXRoIGFyYml0cmFyeSBzaXplcy4gU28gYXQgdGhl
IGVuZCBvZiB0aGUNCj4gPj4+ICAgICAgICBkYXkgYXBwbGljYXRpb25zIHRoYXQgdXNlIGEgY29u
dGlndW91cyBhZGRyZXNzIHNwYWNlIC0gbGlrZSBpbiBhDQo+ID4+PiAgICAgICAgY29udmVudGlv
bmFsIGJsb2NrIGRldmljZSAtLCB3aWxsIGhhdmUgdG8gZGVhbCB3aXRoIHRoaXMuDQo+ID4+DQo+
ID4+ICJ0aGUgYWN0dWFsIGRhdGEgcGxhY2VtZW50IGFsZ29yaXRobXMgbmVlZCB0byBkZWFsIHdp
dGggYXJiaXRyYXJ5IHNpemVzIg0KPiA+Pg0KPiA+PiA/Pz8NCj4gPj4NCj4gPj4gTm8gaXQgZG9l
cyBub3QuIFdpdGggem9uZSBjYXAgPCB6b25lIHNpemUsIHRoZSBhbW91bnQgb2Ygc2VjdG9ycyB0
aGF0IGNhbiBiZQ0KPiA+PiB1c2VkIHdpdGhpbiBhIHpvbmUgbWF5IGJlIHNtYWxsZXIgdGhhbiB0
aGUgem9uZSBzaXplLCBidXQ6DQo+ID4+IDEpIFdyaXRlcyBzdGlsbCBtdXN0IGJlIGlzc3VlZCBh
dCB0aGUgV1AgbG9jYXRpb24gc28gY2hvb3NpbmcgYSB6b25lIGZvciB3cml0aW5nDQo+ID4+IGRh
dGEgaGFzIHRoZSBzYW1lIGNvbnN0cmFpbnQgcmVnYXJkbGVzcyBvZiB0aGUgem9uZSBjYXBhY2l0
eTogRG8gSSBoYXZlIGVub3VnaA0KPiA+PiB1c2FibGUgc2VjdG9ycyBsZWZ0IGluIHRoZSB6b25l
ID8NCj4gPiANCj4gPiBBcmUgeW91IHNheWluZyBob2xlcyBhcmUgaXJyZWxldmFudCBiZWNhdXNl
IGFuIGFwcGxpY2F0aW9uIGhhcyB0byBrbm93IHRoZSANCj4gPiBzdGF0dXMgb2YgYSB6b25lIGJ5
IHF1ZXJ5aW5nIHRoZSBkZXZpY2UgZm9yIHRoZSB6b25lIHN0YXR1cyBiZWZvcmUgdXNpbmcgYSB6
b25lDQo+ID4gYW5kIGF0IHRoYXQgcG9pbnQgaXQgc2hvdWxkIGtub3cgYSBzdGFydCBMQkE/IEkg
c2VlIHlvdXIgcG9pbnQgaGVyZSBidXQgd2UgaGF2ZQ0KPiA+IHRvIGFzc3VtZSB0aGluZ3MgdG8g
YXJyaXZlIGF0IHRoaXMgY29uY2x1c2lvbi4NCj4gDQo+IE9mIGNvdXJzZSBob2xlcyBhcmUgcmVs
ZXZhbnQuIEJ1dCB0aGVpciBwcmVzZW5jZSBkb2VzIG5vdCBjb21wbGljYXRlIGFueXRoaW5nDQo+
IGJlY2F1c2UgdGhlIGJhc2ljIG1hbmFnZW1lbnQgb2Ygem9uZXMgYWxyZWFkeSBoYXMgdG8gZGVh
bCB3aXRoIDIgc2VjdG9yIHJhbmdlcw0KPiBpbiBhbnkgem9uZTogc2VjdG9ycyB0aGF0IGhhdmUg
YWxyZWFkeSBiZWVuIHdyaXR0ZW4gYW5kIHRoZSBvbmUgdGhhdCBoYXZlIG5vdC4NCj4gVGhlICJo
b2xlIiBmb3Igem9uZSBjYXBhY2l0eSAhPSB6b25lIHNpemUgY2FzZSBpcyBzaW1wbHkgYW5vdGhl
ciByYW5nZSB0byBiZQ0KPiBpZ25vcmVkLg0KPiANCj4gQW5kIHRoZSBvbmx5IHRoaW5nIEkgYW0g
YXNzdW1pbmcgaGVyZSBpcyB0aGF0IHRoZSBzb2Z0d2FyZSBoYXMgYSBkZWNlbnQgZGVzaWduLA0K
PiB0aGF0IGlzLCBpdCBpcyBpbmRlZWQgem9uZSBhd2FyZSBhbmQgbWFuYWdlcyB6b25lcyAodGhl
aXIgc3RhdGUgYW5kIHdwDQo+IHBvc2l0aW9uKS4gVGhhdCBkb2VzIG5vdCBtZWFuIHRoYXQgb25l
IG5lZWRzIHRvIGRvIGEgcmVwb3J0IHpvbmVzIGJlZm9yZSBldmVyeQ0KPiBJTyAod2VsbCwgZHVt
YiBhcHBsaWNhdGlvbiBjYW4gZG8gdGhhdCBpZiB0aGV5IHdhbnQpLiBab25lIG1hbmFnZW1lbnQg
aXMNCj4gaW5pdGlhbGl6ZWQgdXNpbmcgYSByZXBvcnQgem9uZSBjb21tYW5kIGluZm9ybWF0aW9u
IGJ1dCBjYW4gYmUgdGhlbiBiZSBjYWNoZWQgb24NCj4gdGhlIGhvc3QgZHJhbSBpbiBhbnkgZm9y
bSBzdWl0YWJsZSBmb3IgdGhlIGFwcGxpY2F0aW9uLg0KPiANCj4gPiANCj4gPiBMZXQncyB0aGlu
ayBvZiBhbm90aGVyIHNjZW5hcmlvIHdoZXJlIHRoZSBkcml2ZSBpcyBtYW5hZ2VkIGJ5IGEgdXNl
ciBzcGFjZSANCj4gPiBhcHBsaWNhdGlvbiB0aGF0IGtub3dzIHRoZSBzdGF0dXMgb2Ygem9uZXMg
YW5kIHBpY2tzIGEgem9uZSBiZWNhdXNlIGl0IGtub3dzIA0KPiA+IGl0IGlzIGZyZWUuIFRvIGNh
bGN1bGF0ZSB0aGUgc3RhcnQgb2Zmc2V0IGluIHRlcm1zIG9mIExCQXMgdGhlIGFwcGxpY2F0aW9u
IGhhcyANCj4gPiB0byB1c2UgdGhlIGRpZmZlcmVuY2UgaW4gem9uZV9zaXplIGFuZCB6b25lX2Nh
cCB0byBjYWxjdWxhdGUgdGhlIHdyaXRlIG9mZnNldA0KPiA+IGluIHRlcm1zIG9mIExCQXMuIA0K
PiANCj4gV2hhdCA/IFRoaXMgZG9lcyBub3QgbWFrZSBzZW5zZS4gVGhlIGFwcGxpY2F0aW9uIHNp
bXBseSBuZWVkcyB0byBrbm93IHRoZQ0KPiBjdXJyZW50ICJzb2Z0IiB3cCBwb3NpdGlvbiBhbmQg
aXNzdWUgd3JpdGVzIGF0IHRoYXQgcG9zaXRpb24gYW5kIGluY3JlbWVudCBpdA0KPiByaWdodCBh
d2F5IHdpdGggdGhlIG51bWJlciBvZiBzZWN0b3JzIHdyaXR0ZW4uIE9uY2UgdGhhdCBwb3NpdGlv
biByZWFjaGVzIHpvbmUNCj4gY2FwLCB0aGUgem9uZSBpcyBmdWxsLiBUaGUgaG9sZSBiZWhpbmQg
dGhhdCBjYW4gYmUgaWdub3JlZC4gV2hhdCBpcyBkaWZmaWN1bHQNCj4gd2l0aCB0aGlzID8gVGhp
cyBpcyB6b25lIHN0b3JhZ2UgdXNlIDEwMS4NCg0KU291bmRzIGxpa2UgeW91IHZvbHVudGVyZWQg
dG8gdGVhY2ggem9uZWQgc3RvcmFnZSB1c2UgMTAxLiBDYW4geW91IHRlYWNoIG1lIGhvdw0KdG8g
Y2FsY3VsYXRlIGFuIExCQSBvZmZzZXQgZ2l2ZW4gYSB6b25lIG51bWJlciB3aGVuIHpvbmUgY2Fw
YWNpdHkgaXMgbm90IGVxdWFsDQp0byB6b25lIHNpemU/DQoNClRoZSBzZWNvbmQgdGhpbmcgSSB3
b3VsZCBsaWtlIHRvIGtub3cgaXMgd2hhdCBoYXBwZW5zIHdoZW4gYW4gYXBwbGljYXRpb24gd2Fu
dHMNCnRvIG1hcCBhbiBvYmplY3QgdGhhdCBzcGFucyBtdWx0aXBsZSBjb25zZWN1dGl2ZSB6b25l
cy4gRG9lcyB0aGUgYXBwbGljYXRpb24gDQpoYXZlIHRvIGJlIGF3YXJlIG9mIHRoZSBkaWZmZXJl
bmNlIGluIHpvbmUgY2FwYWNpdHkgYW5kIHpvbmUgc2l6ZT8NCg0KPiANCj4gPiBNeSBhcmd1bWVu
dCBpcyB0aGF0IHRoZSB6b25lX3NpemUgaXMgYSBjb25zdHJ1Y3QgY29uY2VpdmVkIHRvIG1ha2Ug
YSBaTlMgem9uZQ0KPiA+IGEgcG93ZXIgb2YgMiB0aGF0IGNyZWF0ZXMgYSBob2xlIGluIHRoZSBM
QkEgc3BhY2UuIEFwcGxpY2F0aW9ucyBkb24ndCB3YW50DQo+ID4gdG8gZGVhbCB3aXRoIHRoZSBw
b3dlciBvZiAyIGNvbnN0cmFpbnQgYW5kIG5laXRoZXIgZG8gZGV2aWNlcy4gSXQgc2VlbXMgbGlr
ZQ0KPiA+IHRoZSBleGlzdGluZyB6b25lZCBrZXJuZWwgaW5mcmFzdHJ1Y3R1cmUsIHdoaWNoIG1h
ZGUgc2Vuc2UgZm9yIFNNUiwgcHVzaGVkIA0KPiA+IHRoaXMgY29uc3RyYWludCBvbnRvIGRldmlj
ZXMgYW5kIG9udG8gdXNlcnMuIEFyZ3VtZW50cyBjYW4gYmUgbWFkZSBmb3Igd2hlcmUgDQo+ID4g
Y29tcGxleGl0eSBzaG91bGQgbGllLCBidXQgSSBkb24ndCB0aGluayB0aGlzIGRlY2lzaW9uIG1h
ZGUgdGhpbmdzIGVhc2llciBmb3INCj4gPiBzb21lb25lIHRvIHVzZSBhIFpOUyBTU0QgYXMgYSBi
bG9jayBkZXZpY2UuDQo+IA0KPiAiQXBwbGljYXRpb25zIGRvbid0IHdhbnQgdG8gZGVhbCB3aXRo
IHRoZSBwb3dlciBvZiAyIGNvbnN0cmFpbnQiDQo+IA0KPiBXZWxsLCB3ZSBkZWZpbml0ZWx5IGFy
ZSBub3QgdGFsa2luZyB0byB0aGUgc2FtZSB1c2VycyB0aGVuLiBCZWNhdXNlIEkgaGVhcmQgdGhl
DQo+IGNvbnRyYXJ5IGZyb20gdXNlcnMgd2hvIGhhdmUgYWN0dWFsbHkgZGVwbG95ZWQgem9uZWQg
c3RvcmFnZSBhdCBzY2FsZS4gQW5kIHRoZXJlDQo+IGlzIG5vdGhpbmcgdG8gZGVhbCB3aXRoIHBv
d2VyIG9mIDIuIFRoaXMgaXMgbm90IGEgY29uc3RyYWludCBpbiBpdHNlbGYuIEENCj4gcGFydGlj
dWxhciB6b25lIHNpemUgaXMgdGhlIGNvbnN0cmFpbnQgYW5kIGZvciB0aGF0LCB1c2VycyBhcmUg
aW5kZWVkIG5ldmVyDQo+IHNhdGlzZmllZCAoc29tZSB3YW50IHNtYWxsZXIgem9uZXMsIG90aGVy
IGJpZ2dlciB6b25lcykuIFNvIGZhciwgcG93ZXIgb2YgMiBzaXplDQo+IGhhcyBiZWVuIG1vc3Rs
eSBpcnJlbGV2YW50IG9yIGFjdHVhbGx5IHJlcXVpcmVkIGJlY2F1c2UgZXZlcnlib2R5IHVuZGVy
c3RhbmRzDQo+IHRoZSBDUFUgbG9hZCBiZW5lZml0cyBvZiBiaXQgc2hpZnQgYXJpdGhtZXRpYyBh
cyBvcHBvc2VkIHRvIENQVSBjeWNsZSBodW5ncnkNCj4gbXVsdGlwbGljYXRpb25zIGFuZCBkaXZp
c2lvbnMuDQoNCllvdSBhcmUgdGhpbmtpbmcgZnJvbSBhIGtlcm5lbCBwZXJzcGVjdGl2ZSB5b3Ug
YXJlIHBvdGVudGlhbGx5IHB1c2hpbmcgDQphZGRpdGlvbmFsIG11bHRpcGxpY2F0aW9ucyBvbnRv
IHVzZXJzLiBUaGlzIHNob3VsZCBiZSBjbGVhciBpZiB3ZSBsZWFybiBtb3JlIA0KYWJvdXQgem9u
ZWQgc3RvcmFnZSAxMDEgaW4gdGhpcyB0aHJlYWQuDQoNCj4gDQo+ID4gDQo+ID4+IDIpIFJlYWRp
bmcgYWZ0ZXIgdGhlIFdQIGlzIG5vdCB1c2VmdWwgKGlmIG5vdCBvdXRyaWdodCBzdHVwaWQpLCBy
ZWdhcmRsZXNzIG9mDQo+ID4+IHdoZXJlIHRoZSBsYXN0IHVzYWJsZSBzZWN0b3IgaW4gdGhlIHpv
bmUgaXMgKGF0IHpvbmUgc3RhcnQgKyB6b25lIHNpemUgb3IgYXQNCj4gPj4gem9uZSBzdGFydCAr
IHpvbmUgY2FwKS4NCj4gPiANCj4gPiBPZiBjb3Vyc2UgYnV0IHRoZSB3aXRoIHBvMiB5b3UgZm9y
Y2UgdXNlbGVzcyBMQkEgc3BhY2UgZXZlbiBpZiB5b3UgZmlsbCBhIHpvbmUuDQo+IA0KPiBBbmQg
bXkgcG9pbnQgaXM6IHNvIHdoYXQgPyBJIGRvIG5vdCBzZWUgdGhpcyBhcyBhIHByb2JsZW0gZ2l2
ZW4gdGhhdCBhY2Nlc3Nlcw0KPiBtdXN0IGJlIHpvbmUgYmFzZWQgYW55d2F5Lg0KPiANCj4gPj4g
QW5kIHRhbGtpbmcgYWJvdXQgInVzZSBhIGNvbnRpZ3VvdXMgYWRkcmVzcyBzcGFjZSIgaXMgaW4g
bXkgb3BpbmlvbiBub25zZW5zZSBpbg0KPiA+PiB0aGUgY29udGV4dCBvZiB6b25lZCBzdG9yYWdl
IHNpbmNlIGJ5IGRlZmluaXRpb24sIGV2ZXJ5dGhpbmcgaGFzIHRvIGJlIG1hbmFnZWQNCj4gPj4g
dXNpbmcgem9uZXMgYXMgdW5pdHMuIFRoZSBvbmx5IHNlbnNpYmxlIHJhbmdlIGZvciBhICJjb250
aWd1b3VzIGFkZHJlc3Mgc3BhY2UiDQo+ID4+IGlzICJ6b25lIHN0YXJ0ICsgbWluKHpvbmUgY2Fw
LCB6b25lIHNpemUpIi4NCj4gPiANCj4gPiBEZWZpbml0ZWx5IGRpc2FncmVlIHdpdGggdGhpcyBn
aXZlbiBwcmV2aW91cyBhcmd1bWVudHMuIFRoaXMgaXMgYSBjb25zdHJ1Y3QgDQo+ID4gZm9yY2Vk
IHVwb24gdXMgYmVjYXVzZSBvZiB6b25lZCBzdG9yYWdlIGxlZ2FjeS4NCj4gDQo+IFdoYXQgY29u
c3RydWN0ID8gVGhlIHpvbmUgaXMgdGhlIHVuaXQuIE5vIG1hdHRlciBpdHMgc2l6ZSwgaXQgKm11
c3QqIHJlbWFpbiB0aGUNCj4gYWNjZXNzIG1hbmFnZW1lbnQgdW5pdCBmb3IgdGhlIHpvbmVkIHNv
ZnR3YXJlIHRvcCBiZSBjb3JyZWN0LiBUaGlua2luZyB0aGF0IG9uZQ0KPiBjYW4gY29ycmVjdGx5
IGltcGxlbWVudCBhIHpvbmUgY29tcGxpYW50IGFwcGxpY2F0aW9uLCBvciBhbnkgcGllY2Ugb2Yg
c29mdHdhcmUsDQo+IHdpdGhvdXQgbWFuYWdpbmcgem9uZXMgYW5kIHVzaW5nIHRoZW0gYXMgdGhl
IHN0b3JhZ2UgdW5pdCBpcyBpbiBteSBvcGluaW9uIGEgYmFkDQo+IGRlc2lnbiBib3VuZCB0byBm
YWlsLg0KPiANCg0KRm9yY2luZyBhIHpvbmUgdG8gYmUgcG93ZXIgb2YgMiBzaXplLiBGb3IgTkFO
RCBpdCBpcyBzb21ldGhpbmcgdGhhdCBpdCBpcyANCm5vdC4gQ2FwYWNpdHkgdnMgc2l6ZSBkb2Vz
bid0IHNvbHZlIGFueSByZWFsIHByb2JsZW0gb3RoZXIgdGhhbiBtYWtpbmcgWk5TIGZpdA0KdGhl
IHpvbmVkIG1vZGVsIHRoYXQgd2FzIGNvbmNlaXZlZCBmb3IgSEREcy4NCg0KPiBJIG1heSBiZSB3
cm9uZywgb2YgY291cnNlLCBidXQgSSBzdGlsbCBoYXZlIHRvIGJlIHByb3ZlbiBzbyBieSBhbiBh
Y3R1YWwgdXNlIGNhc2UuDQo+IA0KPiA+IA0KPiA+Pg0KPiA+Pj4gICAgICAgIFNpbmNlIGNodW5r
X3NlY3RvcnMgaXMgbm8gbG9uZ2VyIHJlcXVpcmVkIHRvIGJlIGEgUE8yLCB3ZSBoYXZlDQo+ID4+
PiAgICAgICAgc3RhcnRlZCB0aGUgd29yayBpbiByZW1vdmluZyB0aGlzIGNvbnN0cmFpbnQuIFdl
IGFyZSB3b3JraW5nIGluIDINCj4gPj4+ICAgICAgICBwaGFzZXM6DQo+ID4+Pg0KPiA+Pj4gICAg
ICAgICAgMS4gQWRkIGFuIGVtdWxhdGlvbiBsYXllciBpbiBOVk1lIGRyaXZlciB0byBzaW11bGF0
ZSBQTzIgZGV2aWNlcw0KPiA+Pj4gCXdoZW4gdGhlIEhXIHByZXNlbnRzIGEgem9uZV9jYXBhY2l0
eSA9IHpvbmVfc2l6ZS4gVGhpcyBpcyBhDQo+ID4+PiAJcHJvZHVjdCBvZiBvbmUgb2YgRGFtaWVu
J3MgZWFybHkgY29uY2VybnMgYWJvdXQgc3VwcG9ydGluZw0KPiA+Pj4gCWV4aXN0aW5nIGFwcGxp
Y2F0aW9ucyBhbmQgRlNzIHRoYXQgd29yayB1bmRlciB0aGUgUE8yDQo+ID4+PiAJYXNzdW1wdGlv
bi4gV2Ugd2lsbCBwb3N0IHRoZXNlIHBhdGNoZXMgaW4gdGhlIG5leHQgZmV3IGRheXMuDQo+ID4+
Pg0KPiA+Pj4gICAgICAgICAgMi4gUmVtb3ZlIHRoZSBQTzIgY29uc3RyYWludCBmcm9tIHRoZSBi
bG9jayBsYXllciBhbmQgYWRkDQo+ID4+PiAJc3VwcG9ydCBmb3IgYXJiaXRyYXJ5IHpvbmUgc3Vw
cG9ydCBpbiBidHJmcy4gVGhpcyB3aWxsIGFsbG93IHRoZQ0KPiA+Pj4gCXJhdyBibG9jayBkZXZp
Y2UgdG8gYmUgcHJlc2VudCBmb3IgYXJiaXRyYXJ5IHpvbmUgc2l6ZXMgKGFuZA0KPiA+Pj4gCWNh
cGFjaXRpZXMpIGFuZCBidHJmcyB3aWxsIGJlIGFibGUgdG8gdXNlIGl0IG5hdGl2ZWx5Lg0KPiA+
Pg0KPiA+PiBab25lIHNpemVzIGNhbm5vdCBiZSBhcmJpdHJhcnkgaW4gYnRyZnMgc2luY2UgYmxv
Y2sgZ3JvdXBzIG11c3QgYmUgYSBtdWx0aXBsZSBvZg0KPiA+PiA2NEsuIFNvIGNvbnN0cmFpbnRz
IHJlbWFpbiBhbmQgc2hvdWxkIGJlIGVuZm9yY2VkLCBhdCBsZWFzdCBieSBidHJmcy4NCj4gPiAN
Cj4gPiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBiYXNlIGEgbG90IG9mIGRlY2lzaW9ucyBvbiB0
aGUgd29yayB0aGF0IGhhcyBnb25lIGludG8gDQo+ID4gYnRyZnMuIEkgdGhpbmsgaXQgaXMgdmVy
eSBwcm9taXNpbmcsIGJ1dCBJIGRvbid0IHRoaW5rIGl0IGlzIHNldHRsZWQgdGhhdCBpdCANCj4g
PiBpcyB0aGUgb25seSB3YXkgcGVvcGxlIHdpbGwgY29uc3VtZSBaTlMgU1NEcy4NCj4gDQo+IE9m
IGNvdXJzZSBpdCBpcyBub3QuIEJ1dCBub3Qgc2F0aXNmeWluZyB0aGlzIGNvbnN0cmFpbnQgZXNz
ZW50aWFsbHkgZGlzYWJsZXMNCj4gYnRyZnMgc3VwcG9ydC4gRXZlciBoZWFyZCBvZiBhIHJlZ3Vs
YXIgYmxvY2sgZGV2aWNlIHRoYXQgeW91IGNhbm5vdCBmb3JtYXQgd2l0aA0KPiBleHQ0IG9yIHhm
cyA/IEl0IGlzIHRoZSBzYW1lIGhlcmUuDQo+IA0KPiANCj4gLS0gDQo+IERhbWllbiBMZSBNb2Fs
DQo+IFdlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA==
