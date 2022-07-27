Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B640582934
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiG0PBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 11:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiG0PB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:01:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447CA45042
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 08:01:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i8so1783678wro.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=8fdJ2c/W0zQvr7pxLXtaQhjINKxajtULw47tq+Ial1I=;
        b=g4dcungGaYehAg1fE3UjNhzSBg9NbP+jT1Jb/eD85JHAW/rT7uWAT7rU+kSBrvRgnP
         dl1wCR6LqLUVnG3QXSobRqvpUCcQEuNeZxajEtxcteIXOE2AC5VCJ2Dd7AqIHN86PRst
         EslHcUImcRlao6c0Kd4CkqqETJwPIjr8Ew4lH2O0hvhfxvismOaH0hZ2PvYfO7aw/z6W
         VsfUjxqfN98FAMlFARSKbs7S4UfLYfRQs/xfT0j9MnxR4H6PiJ6iCQtOPyIxHDlrOa/A
         9jqXOvqW/8j//Gumb1lz+u212ItwMc0mWwxbM64YeAGAgK8M5gjqZ7D8qgCoxccU2mnz
         xX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=8fdJ2c/W0zQvr7pxLXtaQhjINKxajtULw47tq+Ial1I=;
        b=ixvpHUTAoOg3rqdsYmbeD8u9hUanGPFn7kqcU05ee94/OTS5MDhh22G2CXGDPex0tc
         cG7ESW1Pg3dhfQJMrEmhngIz9Zzt+ky2WBlSTT4IDXgfMc7Y/Hecdc7V318E6jzNu7cF
         f9INwgePrvEDC1KTjS2QcQEs8L6Gt/P0Appzu+K8UXzdKh7YjrZ4YHGy0ldHTUKrtB/n
         8MED6Fzox/pvdId+zK2HJcL8QqI8zF+mixL6x2HkDlzM72KyiwRNjISdGVraEF5CcgTG
         Y7R8NvRSka4ZLXEPkvzgvGAgWJfaJT4yIAhA55THt02845VSEotJckTJhGesNtNnPzok
         wzNw==
X-Gm-Message-State: AJIora/jNqz93CGnYBkk4CBZL8SDlCi05bkiMk8S7dbeRtHwlNxpkXJM
        OHYJs3gcBD9PTOmGsW5OukM=
X-Google-Smtp-Source: AGRyM1tgHpiwA3ZXsW4bSE39WhW6EOpIwFI3gvcKsE90JW/mINSxvlU4eiQT+DNSWUCbXjyJiQ725w==
X-Received: by 2002:a05:600c:4f81:b0:3a3:1f5a:2b6a with SMTP id n1-20020a05600c4f8100b003a31f5a2b6amr3368200wmq.53.1658934085525;
        Wed, 27 Jul 2022 08:01:25 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id c18-20020a056000105200b0021e4f446d43sm16995645wrx.58.2022.07.27.08.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 08:01:24 -0700 (PDT)
Message-ID: <0bc5f919-bcfd-8fd0-a16b-9f060088158a@gmail.com>
Date:   Wed, 27 Jul 2022 17:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: unlinkat(2): New flag AT_DEFER_UNLINK
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nZTV4sIvxTPyY0ullbVlLblT"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nZTV4sIvxTPyY0ullbVlLblT
Content-Type: multipart/mixed; boundary="------------h6dn7yxLBxkubJBM0JcuZswn";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Message-ID: <0bc5f919-bcfd-8fd0-a16b-9f060088158a@gmail.com>
Subject: unlinkat(2): New flag AT_DEFER_UNLINK

--------------h6dn7yxLBxkubJBM0JcuZswn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQWwsDQoNCkknZCBsaWtlIHRvIHN1Z2dlc3QgYSBwb3NzaWJsZSBuZXcgZmxhZyBmb3Ig
dW5saW5rYXQoMik6IEFUX0RFRkVSX1VOTElOSy4NCg0KSXQgd291bGQgYmUgdXNlZnVsIGZv
ciB0aGUgZm9sbG93aW5nIHNjZW5hcmlvOg0KDQpQcm9jZXNzIEEsIHJ1bm5pbmcgYXMgcm9v
dCwgYmluZHMgYSAobm9uLWFic3RyYWN0KSBVbml4IHNvY2tldC4NCkl0IHRoZW4gZm9ya3Mg
YW5kIGV4ZWNzIHByb2Nlc3MgQiwgd2hpY2ggcnVucyBhcyBub2JvZHksIHdoaWNoIGluaGVy
aXRzIA0KdGhlIHNvY2tldCBhbmQgbGlzdGVucyBpbiB0aGUgc29ja2V0Lg0KV2hlbiBCIGVu
ZHMgdXNpbmcgdGhlIHNvY2tldCwgaXQgY2xvc2VzIGl0LCBidXQgaXQgY2FuJ3QgdW5saW5r
IGl0LCBhcyANCnRoZSBmaWxlIGlzIG93bmVkIGJ5IHJvb3QuDQoNClByb2Nlc3MgQSBjYW4n
dCB1bmxpbmsoMikgdGhlIGZpbGUgcmlnaHQgYWZ0ZXIgY3JlYXRpb24sIGJlY2F1c2UgdGhl
IA0KZmlsZSBuYW1lIGlzIHVzZWQgYnkgY2xpZW50cyB0aGF0IHdhbnQgdG8gY29ubmVjdCB0
byB0aGUgc2VydmVyLCBhbmQgb2YgDQpjb3Vyc2UsIHRoZSBmaWxlbmFtZSBpcyB0aGUgaW50
ZXJmYWNlLg0KDQpBbiBvcHRpb24gd291bGQgYmUgdG8gY2hvd24oMikgdGhlIGZpbGUsIGJ1
dCB0aGF0IG1heSBub3QgYmUgZGVzaXJhYmxlLg0KQW5vdGhlciBvcHRpb24gaXMgZmluZGlu
ZyBhIHdheSB0byBjb21tdW5pY2F0ZSBiYWNrIHdpdGggQSB0byBhc2sgZm9yIA0KdGhlIHJl
bW92YWwgb2YgdGhlIHNvY2tldDsgdGhhdCB3b3VsZCBiZSBpbnNhbmUgdG8gaW1wbGVtZW50
LCBjb21wYXJlZCANCnRvIG90aGVyIG9wdGlvbnMuDQoNCk15IHByb3Bvc2FsIGlzIHRvIHRl
bGwgdGhlIGtlcm5lbCB0aGF0IEkgd2FudCB0aGUgZmlsZSB0byBiZSByZW1vdmVkIA0Kd2hl
biB0aGUgbGFzdCBmZCB0byBpdCBoYXMgYmVlbiBjbG9zZWQuDQoNCkl0IGNvdWxkIGJlIGRv
bmUgaW4gYW4gdW5saW5rKDIpIGNhbGwsIG9yIHdpdGggYSBmbGFnIHRvIGJpbmQgKHRoZSAN
CmN1cnJlbnQgQVBJIGRvZXNuJ3QgaGF2ZSBmbGFncywgd2hpY2ggaXMgd2h5IEkgdGhvdWdo
dCBvZiB1bmxpbmthdCgyKSkuDQoNCkkga25vdyB0aGlzIGlzIGJhc2ljYWxseSBtaXJyb3Jp
bmcgdGhlIGJlaGF2aW9yIG9mIGFic3RyYWN0IHNvY2tldHMgd2l0aCANCmZpbGUtYmFja2Vk
IHVuaXggc29ja2V0cy4gIEFuZCBtYXliZSB5b3VyIGFuc3dlciBpcyB0byB1c2UgYWJzdHJh
Y3QgDQpzb2NrZXRzLiAgSSdtIHRyeWluZyB0byBjb252aW5jZSBteSBjbGllbnQgdGhhdCBh
YnN0cmFjdCBzb2NrZXRzIGFyZSB0aGUgDQp3YXkgdG8gZ28uICBCdXQgSSB3YXMgc3RpbGwg
d29uZGVyaW5nLCB3aGlsZSBJIHRyeSB0byBjb252aW5jZSBoaW0sIGlmIA0KdGhpcyB3b3Vs
ZCBiZSBhbiBpbnRlcmVzdGluZyBmZWF0dXJlIGZvciB0aGUga2VybmVsIGFueXdheS4NCg0K
QW5vdGhlciBvcHRpb24gd291bGQgYmUgdG8gZ2l2ZSBTT19SRVVTRUFERFIgYSBtZWFuaW5n
IHdpdGggVW5peCANCnNvY2tldHMsIHNvIHRoYXQgbGVhdmluZyBzb2NrZXQgZmlsZXMgaW4g
dGhlIGZpbGVzeXN0ZW0gd291bGRuJ3QgYmUgYSANCnJlYWwgaXNzdWUuDQoNCkknbSBub3Qg
c3VyZSBpZiB0aGVyZSdzIGEgc2l0dWF0aW9uIHdoZXJlIGR1ZSB0byBoYXZpbmcgbmV0d29y
ayANCm5hbWVzcGFjZSBpc29sYXRpb24gYnV0IHNoYXJlZCBtb3VudCBwb2ludHMsIGZpbGUt
YmFja2VkIHNvY2tldHMgd291bGQgDQpiZSB0aGUgb25seSBzb2x1dGlvbi4gIEknbSBzdGls
bCB0cnlpbmcgdG8gaW52ZXN0aWdhdGUgdGhlIGZ1bGwgY29udGV4dCANCm9mIG15IGNsaWVu
dCB0byBtYWtlIHN1cmUgZmlsZS1iYWNrZWQgdW5peCBzb2NrZXRzIGFyZSByZWFsbHkgbmVj
ZXNzYXJ5Lg0KDQpDaGVlcnMsDQoNCkFsZXgNCg0KLS0gDQpBbGVqYW5kcm8gQ29sb21hcg0K
PGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------h6dn7yxLBxkubJBM0JcuZswn--

--------------nZTV4sIvxTPyY0ullbVlLblT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmLhUz0ACgkQnowa+77/
2zIrbw//UVFaBAvBo8rXhCB0wCDFCMeIk+OBjmzXtJTuVh0+6+IhhxPwrUOPBswk
5LJ8XDL4IZekmRz2+C4cXgR0jbDZJDV1r4w+OpqMzGg2zuR1uhCCrCRPjClG1e9g
x7HhFSlFVkfMTPuEvm04Ji0IwLLRBvliaH0asPmzPvqAXjuDhBi9TNI81nnp611W
oQeWYi06viii0yQbbl/pNYyeY9zMcV7wsnkB64zot8DYW7MGbmHKOmj0uhxXKcZZ
nOJmbBBQyXmWfkhqq6hyfJ+PSVWssGKCh5slGL0ajM5+tm4+Kv1ieSrCKxxHe6AA
QKhKojg957oS8IktUooq9MqVh7mDz7cxnQB8Pzh/jdseS8yqZlgr+Z/lJSwLgfId
iiFOKEuNCIY8fAnabq5+YN/eh0CXtjlI1ltnR8UnNW/NzNv8P7YWxL9HNaL9Eund
9kpXi3poKp3QffYDo3XHPNSFm5wO2PIQClF7xhY7A18sZvp3xHaq7lwH09dW8yM7
REu6NCts4VVpRbEMNYm4aFjbvfHmU4RH5lx3i5g+SV7CfUuN1Nar6HTNnHkrskWJ
KI2qevROw9WBNvkPOnDeI4tuzervlDeQeQV5aNGdI2DGtTrCEEFzMdYaHvfUKEUP
UFPZ9R/2C6bdmr6q9+RQ2/Ivg2b9x/aOP9QCzOLwnZ7rGzW984s=
=JvME
-----END PGP SIGNATURE-----

--------------nZTV4sIvxTPyY0ullbVlLblT--
