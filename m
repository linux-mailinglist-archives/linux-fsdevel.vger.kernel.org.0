Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18B673D764
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 07:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFZF6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 01:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZF6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:58:18 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D6E66;
        Sun, 25 Jun 2023 22:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687759083; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CKl1kh/BAo8d4ZITFElBVOa7nULJxQUj+1zu7sgx8RnsjXYS7Kg34BuvBL+rComCRS
    aMGOks5RLRWadlBZXcSc9XDADGTNGm5eNnyRr1Wz+HxlAmrpnvphCpvZ4MCtT7LPoU5D
    qx71XPsJxrTvU8wR8/+6u59g1EKQTaJBz6qqOeQx9KOSnFnZ1pv5FWfptncP4A3Cs/GY
    uD6HEjlzR5QA0mbdVGFgB4KxjfyzQMpuvM5MHd/OuTSdthW7dBS3JkCv1mueGUDN0YxV
    jvSJbjSew0u/JNio13fvpAYuNpJHpSiYJ5InCIy+gtOqucalu7lW7WusfBNAJRrLVnh+
    chcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687759083;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gtZH8ZTdPgSNVa9t73EYpG+kD5sFVs9BHW85u23zt7A=;
    b=U3zR43BAy+2862GYTaL8CbIwmByKzu/qJhAZFFlU4mmglbWkFUUA+SvUxH36wUPZGM
    NwL0wzjgb0zzcnvo20de2w7lqvRoPBBnl5q2W9T1diEfZntHm6pGuAYpWKXvie0dFc4a
    f/xwXr3PO+pSU0fbXmCM8RIfRCPsVzNk5x/yvJl1iCPl2gvQgYG0fXtlf/4t7ZHLd5lP
    EGfGlGeHaSGxLA7ULXmVCfXYTtNzw33PlABbAc7F/8PPcOk1BZ1UF3FyI7dHCX5ZWSuV
    y/gEaUOgjkmXmcsTh5cU2A7QiskIXX+tW1NkaS8AWlEiVv6eABYfrhXSwayBk7cP2p8e
    LQAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687759083;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gtZH8ZTdPgSNVa9t73EYpG+kD5sFVs9BHW85u23zt7A=;
    b=EytPGVy5tJcBww5TmIqfQKwbLj6LpCgbie3fHuss36xwufWhHvwO8F0lrb05wVylJJ
    N9h3lrw/LG9z3WU56mGfOOiz/zCn1+rLOUKGl8EYpC9ioKfl1A4jTcodu1QJRavA8QSf
    hI0vh1zXTswZFbbXmTRemf56kYr/WRl/8/ZfX5L1Vtc7Witj99QSi3996ej+5xV8zUkR
    DbdHCsc/zUQIDMDhSLuPGJDy3RRmosnJUOW9mFqdoV+JPQO65hxJ0TndBpE3l5czAZrg
    lYdk3NlYy0q4dOYSJfdD2KjfJgmQq+/yhW9AiDp/GTVQj2ySC+2KpnO94XJuI9L1hPTo
    sGeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687759083;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gtZH8ZTdPgSNVa9t73EYpG+kD5sFVs9BHW85u23zt7A=;
    b=+dkd0g4VvbVAa8otyU5vCOoKWxvRGOx1DJoFaL5XGNR4XZ6HXdeSRscXSDiV3rfivn
    Fsj0fqiZq82BU1Bc/WDw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyMI1zXvWpofGAfnFnDgkM44n56QuhmdHnY0RKOxJL4CsSg7xJ0="
Received: from p200300c58715a9e981d54b9cd7405ee9.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5Q5w2Vyc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 26 Jun 2023 07:58:02 +0200 (CEST)
Message-ID: <4ced64b8089232ea94b697dec1c3595c8bf427ad.camel@iokpp.de>
Subject: Re: [PATCH v3 0/2] clean up block_commit_write
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        willy@infradead.org, hch@infradead.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Date:   Mon, 26 Jun 2023 07:58:02 +0200
In-Reply-To: <20230626054153.839672-1-beanhuo@iokpp.de>
References: <20230626054153.839672-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CgpwbGVhc2UgaWdub3JlIHRoaXMgc2VyaWVzIHBhdGNoIHNpbmNlIGl0IGhhcyBhIHBhdGNoLXNp
Z25lZCBpc3N1ZSwgScKgCmhhdmUgUkVTRU5UIGl0LiAKCgoKT24gTW9uLCAyMDIzLTA2LTI2IGF0
IDA3OjQxICswMjAwLCBCZWFuIEh1byB3cm90ZToKPiBjaGFuZ2UgbG9nOgo+IMKgwqDCoCB2MS0t
djI6Cj4gwqDCoMKgwqDCoMKgwqAgMS4gcmVvcmRlcmVkIHBhdGNoZXMKPiDCoMKgwqAgdjItdjM6
Cj4gwqDCoMKgwqDCoMKgwqAgMS4gcmViYXNlZCBwYXRjaGVzIHRvCj4gZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dAo+IAo+IAo+IEJl
YW4gSHVvICgyKToKPiDCoCBmcy9idWZmZXI6IGNsZWFuIHVwIGJsb2NrX2NvbW1pdF93cml0ZQo+
IMKgIGZzOiBjb252ZXJ0IGJsb2NrX2NvbW1pdF93cml0ZSB0byByZXR1cm4gdm9pZAo+IAo+IMKg
ZnMvYnVmZmVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIwICsrKysrKysr
LS0tLS0tLS0tLS0tCj4gwqBmcy9leHQ0L21vdmVfZXh0ZW50LmPCoMKgwqDCoMKgwqAgfMKgIDcg
KystLS0tLQo+IMKgZnMvb2NmczIvZmlsZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA3
ICstLS0tLS0KPiDCoGZzL3VkZi9maWxlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCA2ICsrKy0tLQo+IMKgaW5jbHVkZS9saW51eC9idWZmZXJfaGVhZC5oIHzCoCAyICstCj4gwqA1
IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQo+IAoK

