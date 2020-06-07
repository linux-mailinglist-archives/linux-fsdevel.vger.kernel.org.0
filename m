Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042AF1F0F40
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 21:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgFGTtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 15:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGTtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 15:49:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8E2C08C5C4
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2020 12:49:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so17860545ljp.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2020 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVLt6RQOXfHsj9l9Ch+V1UbogXQdw0JcM+o0OH1DfvU=;
        b=FhntX0qUm0nYDAFBYSP+SddZ8NHf7ty0/VV4n/2SJZdTeQFdZJ2hwI9bC5Xy2t/wdg
         aHvN/aOIuWavgxhJ+jHBa3rfvckboeJywyYjXcV3PcT3uQMvgIZv3oB/mx73vxx4ow7j
         Q+d1BiWPja2pPtwnATSE+DEiwHOBIv21r7VQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVLt6RQOXfHsj9l9Ch+V1UbogXQdw0JcM+o0OH1DfvU=;
        b=J4gFAaVNqO3FkBbvYHVDvlU7UHVJ0CxbkO6BJwnMuaLHTBYwODrF+VMTHh26qGhrzP
         tu0THUwfYMdLzxLVV9+c3Dr3NiZ2GnDaVThjm1MctjPLxaVirEiP4xyI6Jzi9ly8kzkN
         X9fD9pYeFZUaroMkle0gDGKVNFkpv2oQpZ509qi5aZzf/DafQyK6+R4A3LrmTfepilZI
         mAxirny7tUxgynqbplLUx5smcN67Y3kXF/76bGSdOrNNmBb9EnoaMEnUXjgCGVYHC3eD
         e8qM5iS4/7b1lhNIV1VgSfLeZQ29Gl1NtAPc+HI+l82z4UHkeTi5XvTK6Q9myX9ahGe/
         MyNQ==
X-Gm-Message-State: AOAM533M+S0E73DUQmEBia8sX1SVfHxE4qXXHzvHMGgMbLexMW0XLitb
        ByqARjvZCrlwwzHPZz4/znm00WJDcwE=
X-Google-Smtp-Source: ABdhPJzer9Z7kRZcxDSJeYxcA5uP95o8mNsK92/r1o0TuYnAbCZuxbzaFEX2NqG1Z3/ktvB6wq7I+w==
X-Received: by 2002:a2e:b6c2:: with SMTP id m2mr10347052ljo.63.1591559352200;
        Sun, 07 Jun 2020 12:49:12 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id o4sm3798959lff.78.2020.06.07.12.49.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 12:49:10 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id n24so17826579lji.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2020 12:49:09 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr2102063ljk.314.1591559349626;
 Sun, 07 Jun 2020 12:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
 <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
 <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk> <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
In-Reply-To: <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jun 2020 12:48:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=widT2tV+sVPzNQWijtUz4JA=CS=EaJRfC3_9ymuQXQS8Q@mail.gmail.com>
Message-ID: <CAHk-=widT2tV+sVPzNQWijtUz4JA=CS=EaJRfC3_9ymuQXQS8Q@mail.gmail.com>
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ac946e05a783c983"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000ac946e05a783c983
Content-Type: text/plain; charset="UTF-8"

On Sun, Jun 7, 2020 at 9:37 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > That will kinda work, except you do that mask &= MAY_RWX before
> > check_acl(), which cares about MAY_NOT_BLOCK and who knows what other bits.
>
> Good catch.

With the change to not clear the non-rwx bits in general, the owner
case now wants to do the masking, and then the "shift left by 6"
modification makes no sense since it only makes for a bigger constant
(the only reason to do the shift-right was so that the bitwise not of
the i_mode could be done in parallel with the shift, but with the
masking that instruction scheduling optimization becomes kind of
immaterial too). So I modified that patch to not bother, and add a
comment about MAY_NOT_BLOCK.

And since I was looking at the MAY_NOT_BLOCK logic, it was not only
not mentioned in comments, it also had some really confusing code
around it.

The posix_acl_permission() looked like it tried to conserve that bit,
which is completely wrong. It wasn't a bug only for the simple reason
that the only two call-sites had either explicitly cleared the bit
when calling, or had tested that the bit wasn't set in the first
place.

So as a result, I wrote a second patch to clear that confusion up.

Rasmus, say the word and I'll mark you for authorship on the first one.

Comments? Can you find something else wrong here, or some other fixup to do?

Al, any reaction?

               Linus

--000000000000ac946e05a783c983
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-vfs-do-not-do-group-lookup-when-not-necessary.patch"
Content-Disposition: attachment; 
	filename="0001-vfs-do-not-do-group-lookup-when-not-necessary.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kb5hbmtt0>
X-Attachment-Id: f_kb5hbmtt0

RnJvbSAwOWNjMGZhZWYwNzY2ZGE4ZmY4ZTZhODJjZmM1YzhjNTNhMDFkMGE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgNSBKdW4gMjAyMCAxMzo0MDo0NSAtMDcwMApTdWJqZWN0OiBb
UEFUQ0ggMS8yXSB2ZnM6IGRvIG5vdCBkbyBncm91cCBsb29rdXAgd2hlbiBub3QgbmVjZXNzYXJ5
CgpSYXNtdXMgVmlsbGVtb2VzIHBvaW50cyBvdXQgdGhhdCB0aGUgJ2luX2dyb3VwX3AoKScgdGVz
dHMgY2FuIGJlIGEKbm90aWNlYWJsZSBleHBlbnNlLCBhbmQgb2Z0ZW4gY29tcGxldGVseSB1bm5l
Y2Vzc2FyeS4gIEEgY29tbW9uCnNpdHVhdGlvbiBpcyB0aGF0IHRoZSAnZ3JvdXAnIGJpdHMgYXJl
IHRoZSBzYW1lIGFzIHRoZSAnb3RoZXInIGJpdHMKd3J0IHRoZSBwZXJtaXNzaW9ucyB3ZSB3YW50
IHRvIHRlc3QuCgpTbyByZXdyaXRlICdhY2xfcGVybWlzc2lvbl9jaGVjaygpJyB0byBub3QgYm90
aGVyIGNoZWNraW5nIGZvciBncm91cApvd25lcnNoaXAgd2hlbiB0aGUgcGVybWlzc2lvbiBjaGVj
ayBkb2Vzbid0IGNhcmUuCgpGb3IgZXhhbXBsZSwgaWYgd2UncmUgYXNraW5nIGZvciByZWFkIHBl
cm1pc3Npb25zLCBhbmQgYm90aCAnZ3JvdXAnIGFuZAonb3RoZXInIGFsbG93IHJlYWRpbmcsIHRo
ZXJlJ3MgcmVhbGx5IG5vIHJlYXNvbiB0byBjaGVjayBpZiB3ZSdyZSBwYXJ0Cm9mIHRoZSBncm91
cCBvciBub3Q6IGVpdGhlciB3YXksIHdlJ2xsIGFsbG93IGl0LgoKUmFzbXVzIHNheXM6CiAiT24g
YSBib2ctc3RhbmRhcmQgVWJ1bnR1IDIwLjA0IGluc3RhbGwsIGEgd29ya2xvYWQgY29uc2lzdGlu
ZyBvZgogIGNvbXBpbGluZyBsb3RzIG9mIHVzZXJzcGFjZSBwcm9ncmFtcyAoaS5lLiwgY2FsbGlu
ZyBsb3RzIG9mCiAgc2hvcnQtbGl2ZWQgcHJvZ3JhbXMgdGhhdCBhbGwgbmVlZCB0byBnZXQgdGhl
aXIgc2hhcmVkIGxpYnMgbWFwcGVkIGluLAogIGFuZCB0aGUgY29tcGlsZXJzIHBva2luZyBhcm91
bmQgbG9va2luZyBmb3Igc3lzdGVtIGhlYWRlcnMgLSBsb3RzIG9mCiAgL3Vzci9saWIsIC91c3Iv
YmluLCAvdXNyL2luY2x1ZGUvIGFjY2Vzc2VzKSBwdXRzIGluX2dyb3VwX3AgYXJvdW5kCiAgMC4x
JSBhY2NvcmRpbmcgdG8gcGVyZiB0b3AuCgogIFN5c3RlbS1pbnN0YWxsZWQgZmlsZXMgYXJlIGFs
bW9zdCBhbHdheXMgMDc1NSAoZGlyZWN0b3JpZXMgYW5kCiAgYmluYXJpZXMpIG9yIDA2NDQsIHNv
IGluIG1vc3QgY2FzZXMsIHdlIGNhbiBhdm9pZCB0aGUgYmluYXJ5IHNlYXJjaAogIGFuZCB0aGUg
Y29zdCBvZiBwdWxsaW5nIHRoZSBjcmVkLT5ncm91cHMgYXJyYXkgYW5kIGluX2dyb3VwX3AoKSAu
dGV4dAogIGludG8gdGhlIGNwdSBjYWNoZSIKClJlcG9ydGVkLWJ5OiBSYXNtdXMgVmlsbGVtb2Vz
IDxsaW51eEByYXNtdXN2aWxsZW1vZXMuZGs+ClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRz
IDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBmcy9uYW1laS5jIHwgNDQgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyOSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9uYW1l
aS5jIGIvZnMvbmFtZWkuYwppbmRleCBkODFmNzNmZjFhOGIuLmU3NGE3ODQ5ZTliNSAxMDA2NDQK
LS0tIGEvZnMvbmFtZWkuYworKysgYi9mcy9uYW1laS5jCkBAIC0yODgsMzcgKzI4OCw1MSBAQCBz
dGF0aWMgaW50IGNoZWNrX2FjbChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQgbWFzaykKIH0KIAog
LyoKLSAqIFRoaXMgZG9lcyB0aGUgYmFzaWMgcGVybWlzc2lvbiBjaGVja2luZworICogVGhpcyBk
b2VzIHRoZSBiYXNpYyBVTklYIHBlcm1pc3Npb24gY2hlY2tpbmcuCisgKgorICogTm90ZSB0aGF0
IHRoZSBQT1NJWCBBQ0wgY2hlY2sgY2FyZXMgYWJvdXQgdGhlIE1BWV9OT1RfQkxPQ0sgYml0LAor
ICogZm9yIFJDVSB3YWxraW5nLgogICovCiBzdGF0aWMgaW50IGFjbF9wZXJtaXNzaW9uX2NoZWNr
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIGludCBtYXNrKQogewogCXVuc2lnbmVkIGludCBtb2RlID0g
aW5vZGUtPmlfbW9kZTsKIAotCWlmIChsaWtlbHkodWlkX2VxKGN1cnJlbnRfZnN1aWQoKSwgaW5v
ZGUtPmlfdWlkKSkpCisJLyogQXJlIHdlIHRoZSBvd25lcj8gSWYgc28sIEFDTCdzIGRvbid0IG1h
dHRlciAqLworCWlmIChsaWtlbHkodWlkX2VxKGN1cnJlbnRfZnN1aWQoKSwgaW5vZGUtPmlfdWlk
KSkpIHsKKwkJbWFzayAmPSA3OwogCQltb2RlID4+PSA2OwotCWVsc2UgewotCQlpZiAoSVNfUE9T
SVhBQ0woaW5vZGUpICYmIChtb2RlICYgU19JUldYRykpIHsKLQkJCWludCBlcnJvciA9IGNoZWNr
X2FjbChpbm9kZSwgbWFzayk7Ci0JCQlpZiAoZXJyb3IgIT0gLUVBR0FJTikKLQkJCQlyZXR1cm4g
ZXJyb3I7Ci0JCX0KKwkJcmV0dXJuIChtYXNrICYgfm1vZGUpID8gLUVBQ0NFUyA6IDA7CisJfQog
Ci0JCWlmIChpbl9ncm91cF9wKGlub2RlLT5pX2dpZCkpCi0JCQltb2RlID4+PSAzOworCS8qIERv
IHdlIGhhdmUgQUNMJ3M/ICovCisJaWYgKElTX1BPU0lYQUNMKGlub2RlKSAmJiAobW9kZSAmIFNf
SVJXWEcpKSB7CisJCWludCBlcnJvciA9IGNoZWNrX2FjbChpbm9kZSwgbWFzayk7CisJCWlmIChl
cnJvciAhPSAtRUFHQUlOKQorCQkJcmV0dXJuIGVycm9yOwogCX0KIAorCS8qIE9ubHkgUldYIG1h
dHRlcnMgZm9yIGdyb3VwL290aGVyIG1vZGUgYml0cyAqLworCW1hc2sgJj0gNzsKKwogCS8qCi0J
ICogSWYgdGhlIERBQ3MgYXJlIG9rIHdlIGRvbid0IG5lZWQgYW55IGNhcGFiaWxpdHkgY2hlY2su
CisJICogQXJlIHRoZSBncm91cCBwZXJtaXNzaW9ucyBkaWZmZXJlbnQgZnJvbQorCSAqIHRoZSBv
dGhlciBwZXJtaXNzaW9ucyBpbiB0aGUgYml0cyB3ZSBjYXJlCisJICogYWJvdXQ/IE5lZWQgdG8g
Y2hlY2sgZ3JvdXAgb3duZXJzaGlwIGlmIHNvLgogCSAqLwotCWlmICgobWFzayAmIH5tb2RlICYg
KE1BWV9SRUFEIHwgTUFZX1dSSVRFIHwgTUFZX0VYRUMpKSA9PSAwKQotCQlyZXR1cm4gMDsKLQly
ZXR1cm4gLUVBQ0NFUzsKKwlpZiAobWFzayAmIChtb2RlIF4gKG1vZGUgPj4gMykpKSB7CisJCWlm
IChpbl9ncm91cF9wKGlub2RlLT5pX2dpZCkpCisJCQltb2RlID4+PSAzOworCX0KKworCS8qIEJp
dHMgaW4gJ21vZGUnIGNsZWFyIHRoYXQgd2UgcmVxdWlyZT8gKi8KKwlyZXR1cm4gKG1hc2sgJiB+
bW9kZSkgPyAtRUFDQ0VTIDogMDsKIH0KIAogLyoqCiAgKiBnZW5lcmljX3Blcm1pc3Npb24gLSAg
Y2hlY2sgZm9yIGFjY2VzcyByaWdodHMgb24gYSBQb3NpeC1saWtlIGZpbGVzeXN0ZW0KICAqIEBp
bm9kZToJaW5vZGUgdG8gY2hlY2sgYWNjZXNzIHJpZ2h0cyBmb3IKLSAqIEBtYXNrOglyaWdodCB0
byBjaGVjayBmb3IgKCVNQVlfUkVBRCwgJU1BWV9XUklURSwgJU1BWV9FWEVDLCAuLi4pCisgKiBA
bWFzazoJcmlnaHQgdG8gY2hlY2sgZm9yICglTUFZX1JFQUQsICVNQVlfV1JJVEUsICVNQVlfRVhF
QywKKyAqCQklTUFZX05PVF9CTE9DSyAuLi4pCiAgKgogICogVXNlZCB0byBjaGVjayBmb3IgcmVh
ZC93cml0ZS9leGVjdXRlIHBlcm1pc3Npb25zIG9uIGEgZmlsZS4KICAqIFdlIHVzZSAiZnN1aWQi
IGZvciB0aGlzLCBsZXR0aW5nIHVzIHNldCBhcmJpdHJhcnkgcGVybWlzc2lvbnMKLS0gCjIuMjcu
MC5yYzEuOC5nMDRiZDBjODBkNwoK
--000000000000ac946e05a783c983
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-vfs-clean-up-posix_acl_permission-logic-aroudn-MAY_N.patch"
Content-Disposition: attachment; 
	filename="0002-vfs-clean-up-posix_acl_permission-logic-aroudn-MAY_N.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kb5hbqjh1>
X-Attachment-Id: f_kb5hbqjh1

RnJvbSBlYWQwY2ZlNjhlMDRjMTY3MDM0NDA1YTc4NTg3ODA1OGNlYjZkNTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFN1biwgNyBKdW4gMjAyMCAxMjoxOTowNiAtMDcwMApTdWJqZWN0OiBb
UEFUQ0ggMi8yXSB2ZnM6IGNsZWFuIHVwIHBvc2l4X2FjbF9wZXJtaXNzaW9uKCkgbG9naWMgYXJv
dWRuCiBNQVlfTk9UX0JMT0NLCgpwb3NpeF9hY2xfcGVybWlzc2lvbigpIGRvZXMgbm90IGNhcmUg
YWJvdXQgTUFZX05PVF9CTE9DSywgYW5kIGluIGZhY3QKdGhlIHBlcm1pc3Npb24gbG9naWMgaW50
ZXJuYWxseSBtdXN0IG5vdCBjaGVjayB0aGF0IGJpdCAoaXQncyBvbmx5IGZvcgp1cHBlciBsYXll
cnMgdG8gZGVjaWRlIHdoZXRoZXIgdGhleSBjYW4gYmxvY2sgdG8gZG8gSU8gdG8gbG9vayB1cCB0
aGUKYWNsIGluZm9ybWF0aW9uIG9yIG5vdCkuCgpCdXQgdGhlIHdheSB0aGUgY29kZSB3YXMgd3Jp
dHRlbiwgaXQgX2xvb2tlZF8gbGlrZSBpdCBjYXJlZCwgc2luY2UgdGhlCmZ1bmN0aW9uIGV4cGxp
Y2l0bHkgZGlkIG5vdCBtYXNrIHRoYXQgYml0IG9mZi4KCkJ1dCBpdCBoYXMgZXhhY3RseSB0d28g
Y2FsbGVyczogb25lIGZvciB3aGVuIHRoYXQgYml0IGlzIHNldCwgd2hpY2gKZmlyc3QgY2xlYXJz
IHRoZSBiaXQgYmVmb3JlIGNhbGxpbmcgcG9zaXhfYWNsX3Blcm1pc3Npb24oKSwgYW5kIHRoZQpv
dGhlciBjYWxsIHNpdGUgd2hlbiB0aGF0IGJpdCB3YXMgY2xlYXIuCgpTbyBzdG9wIHRoZSBzaWxs
eSBnYW1lcyAic2F2aW5nIiB0aGUgTUFZX05PVF9CTE9DSyBiaXQgdGhhdCBtdXN0IG5vdCBiZQp1
c2VkIGZvciB0aGUgYWN0dWFsIHBlcm1pc3Npb24gdGVzdCwgYW5kIHRoYXQgY3VycmVudGx5IGlz
IHBvaW50bGVzc2x5CmNsZWFyZWQgYnkgdGhlIGNhbGxlcnMgd2hlbiB0aGUgZnVuY3Rpb24gaXRz
ZWxmIHNob3VsZCBqdXN0IG5vdCBjYXJlLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMg
PHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGZzL25hbWVpLmMgICAgIHwgMiAr
LQogZnMvcG9zaXhfYWNsLmMgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9uYW1laS5jIGIvZnMvbmFtZWkuYwpp
bmRleCBlNzRhNzg0OWU5YjUuLjcyZDQyMTljOTNhYyAxMDA2NDQKLS0tIGEvZnMvbmFtZWkuYwor
KysgYi9mcy9uYW1laS5jCkBAIC0yNzEsNyArMjcxLDcgQEAgc3RhdGljIGludCBjaGVja19hY2wo
c3RydWN0IGlub2RlICppbm9kZSwgaW50IG1hc2spCiAJCS8qIG5vIC0+Z2V0X2FjbCgpIGNhbGxz
IGluIFJDVSBtb2RlLi4uICovCiAJCWlmIChpc191bmNhY2hlZF9hY2woYWNsKSkKIAkJCXJldHVy
biAtRUNISUxEOwotCSAgICAgICAgcmV0dXJuIHBvc2l4X2FjbF9wZXJtaXNzaW9uKGlub2RlLCBh
Y2wsIG1hc2sgJiB+TUFZX05PVF9CTE9DSyk7CisJICAgICAgICByZXR1cm4gcG9zaXhfYWNsX3Bl
cm1pc3Npb24oaW5vZGUsIGFjbCwgbWFzayk7CiAJfQogCiAJYWNsID0gZ2V0X2FjbChpbm9kZSwg
QUNMX1RZUEVfQUNDRVNTKTsKZGlmZiAtLWdpdCBhL2ZzL3Bvc2l4X2FjbC5jIGIvZnMvcG9zaXhf
YWNsLmMKaW5kZXggMjQ5NjcyYmY1NGZlLi45NTg4MmIzZjVmNjIgMTAwNjQ0Ci0tLSBhL2ZzL3Bv
c2l4X2FjbC5jCisrKyBiL2ZzL3Bvc2l4X2FjbC5jCkBAIC0zNTAsNyArMzUwLDcgQEAgcG9zaXhf
YWNsX3Blcm1pc3Npb24oc3RydWN0IGlub2RlICppbm9kZSwgY29uc3Qgc3RydWN0IHBvc2l4X2Fj
bCAqYWNsLCBpbnQgd2FudCkKIAljb25zdCBzdHJ1Y3QgcG9zaXhfYWNsX2VudHJ5ICpwYSwgKnBl
LCAqbWFza19vYmo7CiAJaW50IGZvdW5kID0gMDsKIAotCXdhbnQgJj0gTUFZX1JFQUQgfCBNQVlf
V1JJVEUgfCBNQVlfRVhFQyB8IE1BWV9OT1RfQkxPQ0s7CisJd2FudCAmPSBNQVlfUkVBRCB8IE1B
WV9XUklURSB8IE1BWV9FWEVDOwogCiAJRk9SRUFDSF9BQ0xfRU5UUlkocGEsIGFjbCwgcGUpIHsK
ICAgICAgICAgICAgICAgICBzd2l0Y2gocGEtPmVfdGFnKSB7Ci0tIAoyLjI3LjAucmMxLjguZzA0
YmQwYzgwZDcKCg==
--000000000000ac946e05a783c983--
