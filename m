Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D664B5DE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 23:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiBNWrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 17:47:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiBNWq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:46:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB97634F;
        Mon, 14 Feb 2022 14:46:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26EBE210EF;
        Mon, 14 Feb 2022 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644878809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hY4+tZtVO3bfuQVQvZiqFVanwPAU0lbx3A94noQ9EDw=;
        b=PUxMIzOvsSjt2zgy0CEbtcBLkUWb4c15pX2tyJHCD/8PCeoMR0MkSnZ/KKbiKsY3STmJme
        n388QjpMfoiT5yLKIhwatD4uNF5/VBbZMwdy1Avq7eDtt8JBjAZznrdoX+9RVzvyBxxc0B
        vA51CvixV2m81vY9P41O8UzLWMlcbPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644878809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hY4+tZtVO3bfuQVQvZiqFVanwPAU0lbx3A94noQ9EDw=;
        b=acj5iz4nPJXncE+RYZg9/BSnoT8END2Vlupr8lP/gvNYG2/L58c/HgwTOAv7ooDShcTgRz
        /+LgeV8Bl+UTPGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A185B13B7F;
        Mon, 14 Feb 2022 22:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a9eYFdfbCmKNHgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 14 Feb 2022 22:46:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Ian Kent" <raven@themaw.net>
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
In-reply-to: <b042424ce0e68f576fdab268adeeff90d48da8a8.camel@themaw.net>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>,
 <164444398868.27779.4643380819577932837@noble.neil.brown.name>,
 <b042424ce0e68f576fdab268adeeff90d48da8a8.camel@themaw.net>
Date:   Tue, 15 Feb 2022 09:46:44 +1100
Message-id: <164487880421.17471.502085345359040789@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAxNCBGZWIgMjAyMiwgSWFuIEtlbnQgd3JvdGU6Cj4gT24gVGh1LCAyMDIyLTAyLTEw
IGF0IDA4OjU5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6Cj4gPiBPbiBUdWUsIDE5IE9jdCAyMDIx
LCBJYW4gS2VudCB3cm90ZToKPiA+ID4gSGkgYWxsLAo+ID4gPiAKPiA+ID4gSXQncyB0aW1lIGZv
ciBhIHJlbGVhc2UsIGF1dG9mcy01LjEuOC4KPiA+ID4gCj4gPiAuLi4KPiA+ID4gLSBhbHNvIHJl
cXVpcmUgVENQX1JFUVVFU1RFRCB3aGVuIHNldHRpbmcgTkZTIHBvcnQuCj4gPiAKPiA+IFVuZm9y
dHVuYXRlbHkgdGhhdCBsYXN0IHBhdGNoIGlzIGJ1Z2d5LsKgIFRDUF9SRVFVRVNURUQgaXMgbWFz
a2VkIG91dAo+ID4gaW4KPiA+IHRoZSBjYWxsZXIuCj4gCj4gTW1tIC4uLiBzb3VuZHMgbGlrZSBJ
J3ZlIG1hZGUgYSBtaXN0YWtlIHRoZXJlLgo+IEknbGwgbmVlZCB0byBzb3J0IHRoYXQgb3V0LCB0
aGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4KPiAKPiA+IAo+ID4gTWF5YmUgdGhlIGZvbGxvd2lu
ZyBpcyBiZXN0Lgo+ID4gCj4gPiBOZWlsQnJvd24KPiA+IAo+ID4gRnJvbTogTmVpbEJyb3duIDxu
ZWlsYkBzdXNlLmRlPgo+ID4gU3ViamVjdDogW1BBVENIXSBUZXN0IFRDUCByZXF1ZXN0IGNvcnJl
Y3RseSBpbiBuZnNfZ2V0X2luZm8oKQo+ID4gCj4gPiBUaGUgVENQX1JFUVVFU1RFRCBmbGFnIGlz
IG1hc2tlZCBvdXQgYnkgdGhlIGNhbGxlciwgc28gaXQgbmV2ZXIgZ2V0cwo+ID4gdG8KPiA+IG5m
c19nZXRfaW5mbygpLgo+IAo+IFRoYXQgd2Fzbid0IG15IGludGVudCwgSSdsbCBuZWVkIHRvIGxv
b2sgYXQgaXQgYWdhaW4uCj4gVGhlIGNhc2UgSSdtIHRyeWluZyB0byBjb3ZlciBpcyBmYWlybHkg
c3BlY2lmaWMgc28gSSB3aWxsIG5lZWQgdG8KPiBsb29rIGF0IGl0IGFnYWluLgo+IAoKSSdtIGN1
cmlvdXM6IFdoYXQgd2FzIHRoZSBjYXNlIHlvdSB3ZXJlIHRyeWluZyB0byBzb2x2ZT8/ICBJIGNv
dWxkbid0Cmd1ZXNzIGFueSBqdXN0aWZpY2F0aW9uIGZvciB0aGUgY2hhbmdlLgoKVGhhbmtzLApO
ZWlsQnJvd24KCg==
