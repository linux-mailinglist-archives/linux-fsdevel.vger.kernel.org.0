Return-Path: <linux-fsdevel+bounces-7265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7480823752
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF73B24999
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DAF1DA38;
	Wed,  3 Jan 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hujFp86s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70191DA29
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55539cac143so7756338a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 13:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704318896; x=1704923696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/TvqoF7ldfcuD+idD2xG95uQQkyuBCue6/M91Hiat8=;
        b=hujFp86szPr1aZMGlBHa0FmxYNRyrPQZV3EVVwoW5hZb3Y+zwlQ1OZ/mxmZXVir1GA
         uUloDsqAVACt2Afj5+iituJTt+9DuoMIh7y0CMGviPjs27pLZ6MRPToBayswbRojGQ0J
         O4WUAAdRwH6nMQrSwK7dYza2gZgVBgKs6UvmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704318896; x=1704923696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/TvqoF7ldfcuD+idD2xG95uQQkyuBCue6/M91Hiat8=;
        b=ATsAH09oqrLICYWKhxeHATSgsZJy/nT1DoGrP7L/G8D5F8oU+vAm2NrcaeN8TIWi56
         Cv5R99BPKYxPE8wxT9VxEuipoSqxi2K1pu4ifGn5oAY478PRY44shut3hshC7lyXUoWR
         R1sQCO9bS8c/7BBZjqAaAQvv+LkZNiYTZX1qt4eMfLHb0aeCaYD1+4j3TPj4mCzQ4lv8
         YH0BduKLnfjuD8K0uR0obVTIxL8EYG1qTYjrCmU9XVkG5Sx2Wv+qTzNZmNINeYruIMwb
         eCo0zIdiOQc86VqkU7rIZnb+tZaM0EXS2RhUHXE1+xTCSoM6hv95Jmyc9lAOETzzE03N
         QN6w==
X-Gm-Message-State: AOJu0YxqGSWYbPx5K+LqNk7IMs0ycg2z5NaYrcsS+ftxZnkF0BP1+Omz
	R1EWrEvLfHexeX10bRucGa4hkc17LlUywD1Gnw93YEWb7kwGe4yf
X-Google-Smtp-Source: AGHT+IGQnJDcl8z7MtUX5eBtiIftAEZcaCQGOzDDU8/a53vCs8dNCjx6voRmqOUFvm8sTIoB9WWwyg==
X-Received: by 2002:a50:9ecc:0:b0:556:a717:a744 with SMTP id a70-20020a509ecc000000b00556a717a744mr1555589edf.2.1704318895759;
        Wed, 03 Jan 2024 13:54:55 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7db92000000b00554d6b46a3dsm13116483edt.46.2024.01.03.13.54.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 13:54:54 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26f5e937b5so776289366b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 13:54:54 -0800 (PST)
X-Received: by 2002:a17:906:a043:b0:a28:6317:ceb4 with SMTP id
 bg3-20020a170906a04300b00a286317ceb4mr1512492ejb.76.1704318893840; Wed, 03
 Jan 2024 13:54:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
In-Reply-To: <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 13:54:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
Message-ID: <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="0000000000004080e0060e11aa81"

--0000000000004080e0060e11aa81
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 11:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Or, you know, you could do what I've told you to do at least TEN TIMES
> already, which is to not mess with any of this, and just implement the
> '->permission()' callback (and getattr() to just make 'ls' look sane
> too, rather than silently saying "we'll act as if gid is set right,
> but not show it").

Actually, an even simpler option might be to just do this all at
d_revalidate() time.

Here's an updated patch that builds, and is PURELY AN EXAMPLE. I think
it "works", but it currently always resets the inode mode/uid/gid
unconditionally, which is wrong - it should not do so if the inode has
been manually set.

So take this as a "this might work", but it probably needs a bit more
work - eventfs_set_attr() should set some bit in the inode to say
"these have been set manually", and then revalidate would say "I'll
not touch inodes that have that bit set".

Or something.

Anyway, this patch is nwo relative to your latest pull request, so it
has the check for dentry->d_inode in set_gid() (and still removes the
whole function).

Again: UNTESTED, and meant as a "this is another way to avoid messing
with the dentry tree manually, and just using the VFS interfaces we
already have"

               Linus

--0000000000004080e0060e11aa81
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lqybdnnm0>
X-Attachment-Id: f_lqybdnnm0

IGZzL3RyYWNlZnMvaW5vZGUuYyB8IDE0NyArKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyks
IDEyMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy90cmFjZWZzL2lub2RlLmMgYi9mcy90
cmFjZWZzL2lub2RlLmMKaW5kZXggYmM4NmZmZGIxMDNiLi41YmM5ZTFhMjNhMzEgMTAwNjQ0Ci0t
LSBhL2ZzL3RyYWNlZnMvaW5vZGUuYworKysgYi9mcy90cmFjZWZzL2lub2RlLmMKQEAgLTE4Myw4
NyArMTgzLDYgQEAgc3RydWN0IHRyYWNlZnNfZnNfaW5mbyB7CiAJc3RydWN0IHRyYWNlZnNfbW91
bnRfb3B0cyBtb3VudF9vcHRzOwogfTsKIAotc3RhdGljIHZvaWQgY2hhbmdlX2dpZChzdHJ1Y3Qg
ZGVudHJ5ICpkZW50cnksIGtnaWRfdCBnaWQpCi17Ci0JaWYgKCFkZW50cnktPmRfaW5vZGUpCi0J
CXJldHVybjsKLQlkZW50cnktPmRfaW5vZGUtPmlfZ2lkID0gZ2lkOwotfQotCi0vKgotICogVGFr
ZW4gZnJvbSBkX3dhbGssIGJ1dCB3aXRob3V0IGhlIG5lZWQgZm9yIGhhbmRsaW5nIHJlbmFtZXMu
Ci0gKiBOb3RoaW5nIGNhbiBiZSByZW5hbWVkIHdoaWxlIHdhbGtpbmcgdGhlIGxpc3QsIGFzIHRy
YWNlZnMKLSAqIGRvZXMgbm90IHN1cHBvcnQgcmVuYW1lcy4gVGhpcyBpcyBvbmx5IGNhbGxlZCB3
aGVuIG1vdW50aW5nCi0gKiBvciByZW1vdW50aW5nIHRoZSBmaWxlIHN5c3RlbSwgdG8gc2V0IGFs
bCB0aGUgZmlsZXMgdG8KLSAqIHRoZSBnaXZlbiBnaWQuCi0gKi8KLXN0YXRpYyB2b2lkIHNldF9n
aWQoc3RydWN0IGRlbnRyeSAqcGFyZW50LCBrZ2lkX3QgZ2lkKQotewotCXN0cnVjdCBkZW50cnkg
KnRoaXNfcGFyZW50OwotCXN0cnVjdCBsaXN0X2hlYWQgKm5leHQ7Ci0KLQl0aGlzX3BhcmVudCA9
IHBhcmVudDsKLQlzcGluX2xvY2soJnRoaXNfcGFyZW50LT5kX2xvY2spOwotCi0JY2hhbmdlX2dp
ZCh0aGlzX3BhcmVudCwgZ2lkKTsKLXJlcGVhdDoKLQluZXh0ID0gdGhpc19wYXJlbnQtPmRfc3Vi
ZGlycy5uZXh0OwotcmVzdW1lOgotCXdoaWxlIChuZXh0ICE9ICZ0aGlzX3BhcmVudC0+ZF9zdWJk
aXJzKSB7Ci0JCXN0cnVjdCB0cmFjZWZzX2lub2RlICp0aTsKLQkJc3RydWN0IGxpc3RfaGVhZCAq
dG1wID0gbmV4dDsKLQkJc3RydWN0IGRlbnRyeSAqZGVudHJ5ID0gbGlzdF9lbnRyeSh0bXAsIHN0
cnVjdCBkZW50cnksIGRfY2hpbGQpOwotCQluZXh0ID0gdG1wLT5uZXh0OwotCi0JCS8qIE5vdGUs
IGdldGRlbnRzKCkgY2FuIGFkZCBhIGN1cnNvciBkZW50cnkgd2l0aCBubyBpbm9kZSAqLwotCQlp
ZiAoIWRlbnRyeS0+ZF9pbm9kZSkKLQkJCWNvbnRpbnVlOwotCi0JCXNwaW5fbG9ja19uZXN0ZWQo
JmRlbnRyeS0+ZF9sb2NrLCBERU5UUllfRF9MT0NLX05FU1RFRCk7Ci0KLQkJY2hhbmdlX2dpZChk
ZW50cnksIGdpZCk7Ci0KLQkJLyogSWYgdGhpcyBpcyB0aGUgZXZlbnRzIGRpcmVjdG9yeSwgdXBk
YXRlIHRoYXQgdG9vICovCi0JCXRpID0gZ2V0X3RyYWNlZnMoZGVudHJ5LT5kX2lub2RlKTsKLQkJ
aWYgKHRpICYmICh0aS0+ZmxhZ3MgJiBUUkFDRUZTX0VWRU5UX0lOT0RFKSkKLQkJCWV2ZW50ZnNf
dXBkYXRlX2dpZChkZW50cnksIGdpZCk7Ci0KLQkJaWYgKCFsaXN0X2VtcHR5KCZkZW50cnktPmRf
c3ViZGlycykpIHsKLQkJCXNwaW5fdW5sb2NrKCZ0aGlzX3BhcmVudC0+ZF9sb2NrKTsKLQkJCXNw
aW5fcmVsZWFzZSgmZGVudHJ5LT5kX2xvY2suZGVwX21hcCwgX1JFVF9JUF8pOwotCQkJdGhpc19w
YXJlbnQgPSBkZW50cnk7Ci0JCQlzcGluX2FjcXVpcmUoJnRoaXNfcGFyZW50LT5kX2xvY2suZGVw
X21hcCwgMCwgMSwgX1JFVF9JUF8pOwotCQkJZ290byByZXBlYXQ7Ci0JCX0KLQkJc3Bpbl91bmxv
Y2soJmRlbnRyeS0+ZF9sb2NrKTsKLQl9Ci0JLyoKLQkgKiBBbGwgZG9uZSBhdCB0aGlzIGxldmVs
IC4uLiBhc2NlbmQgYW5kIHJlc3VtZSB0aGUgc2VhcmNoLgotCSAqLwotCXJjdV9yZWFkX2xvY2so
KTsKLWFzY2VuZDoKLQlpZiAodGhpc19wYXJlbnQgIT0gcGFyZW50KSB7Ci0JCXN0cnVjdCBkZW50
cnkgKmNoaWxkID0gdGhpc19wYXJlbnQ7Ci0JCXRoaXNfcGFyZW50ID0gY2hpbGQtPmRfcGFyZW50
OwotCi0JCXNwaW5fdW5sb2NrKCZjaGlsZC0+ZF9sb2NrKTsKLQkJc3Bpbl9sb2NrKCZ0aGlzX3Bh
cmVudC0+ZF9sb2NrKTsKLQotCQkvKiBnbyBpbnRvIHRoZSBmaXJzdCBzaWJsaW5nIHN0aWxsIGFs
aXZlICovCi0JCWRvIHsKLQkJCW5leHQgPSBjaGlsZC0+ZF9jaGlsZC5uZXh0OwotCQkJaWYgKG5l
eHQgPT0gJnRoaXNfcGFyZW50LT5kX3N1YmRpcnMpCi0JCQkJZ290byBhc2NlbmQ7Ci0JCQljaGls
ZCA9IGxpc3RfZW50cnkobmV4dCwgc3RydWN0IGRlbnRyeSwgZF9jaGlsZCk7Ci0JCX0gd2hpbGUg
KHVubGlrZWx5KGNoaWxkLT5kX2ZsYWdzICYgRENBQ0hFX0RFTlRSWV9LSUxMRUQpKTsKLQkJcmN1
X3JlYWRfdW5sb2NrKCk7Ci0JCWdvdG8gcmVzdW1lOwotCX0KLQlyY3VfcmVhZF91bmxvY2soKTsK
LQlzcGluX3VubG9jaygmdGhpc19wYXJlbnQtPmRfbG9jayk7Ci0JcmV0dXJuOwotfQotCiBzdGF0
aWMgaW50IHRyYWNlZnNfcGFyc2Vfb3B0aW9ucyhjaGFyICpkYXRhLCBzdHJ1Y3QgdHJhY2Vmc19t
b3VudF9vcHRzICpvcHRzKQogewogCXN1YnN0cmluZ190IGFyZ3NbTUFYX09QVF9BUkdTXTsKQEAg
LTMxNSw0OSArMjM0LDEyIEBAIHN0YXRpYyBpbnQgdHJhY2Vmc19wYXJzZV9vcHRpb25zKGNoYXIg
KmRhdGEsIHN0cnVjdCB0cmFjZWZzX21vdW50X29wdHMgKm9wdHMpCiAJcmV0dXJuIDA7CiB9CiAK
LXN0YXRpYyBpbnQgdHJhY2Vmc19hcHBseV9vcHRpb25zKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IGJvb2wgcmVtb3VudCkKLXsKLQlzdHJ1Y3QgdHJhY2Vmc19mc19pbmZvICpmc2kgPSBzYi0+c19m
c19pbmZvOwotCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkX2lub2RlKHNiLT5zX3Jvb3QpOwotCXN0
cnVjdCB0cmFjZWZzX21vdW50X29wdHMgKm9wdHMgPSAmZnNpLT5tb3VudF9vcHRzOwotCXVtb2Rl
X3QgdG1wX21vZGU7Ci0KLQkvKgotCSAqIE9uIHJlbW91bnQsIG9ubHkgcmVzZXQgbW9kZS91aWQv
Z2lkIGlmIHRoZXkgd2VyZSBwcm92aWRlZCBhcyBtb3VudAotCSAqIG9wdGlvbnMuCi0JICovCi0K
LQlpZiAoIXJlbW91bnQgfHwgb3B0cy0+b3B0cyAmIEJJVChPcHRfbW9kZSkpIHsKLQkJdG1wX21v
ZGUgPSBSRUFEX09OQ0UoaW5vZGUtPmlfbW9kZSkgJiB+U19JQUxMVUdPOwotCQl0bXBfbW9kZSB8
PSBvcHRzLT5tb2RlOwotCQlXUklURV9PTkNFKGlub2RlLT5pX21vZGUsIHRtcF9tb2RlKTsKLQl9
Ci0KLQlpZiAoIXJlbW91bnQgfHwgb3B0cy0+b3B0cyAmIEJJVChPcHRfdWlkKSkKLQkJaW5vZGUt
PmlfdWlkID0gb3B0cy0+dWlkOwotCi0JaWYgKCFyZW1vdW50IHx8IG9wdHMtPm9wdHMgJiBCSVQo
T3B0X2dpZCkpIHsKLQkJLyogU2V0IGFsbCB0aGUgZ3JvdXAgaWRzIHRvIHRoZSBtb3VudCBvcHRp
b24gKi8KLQkJc2V0X2dpZChzYi0+c19yb290LCBvcHRzLT5naWQpOwotCX0KLQotCXJldHVybiAw
OwotfQotCiBzdGF0aWMgaW50IHRyYWNlZnNfcmVtb3VudChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LCBpbnQgKmZsYWdzLCBjaGFyICpkYXRhKQogewotCWludCBlcnI7CiAJc3RydWN0IHRyYWNlZnNf
ZnNfaW5mbyAqZnNpID0gc2ItPnNfZnNfaW5mbzsKIAogCXN5bmNfZmlsZXN5c3RlbShzYik7Ci0J
ZXJyID0gdHJhY2Vmc19wYXJzZV9vcHRpb25zKGRhdGEsICZmc2ktPm1vdW50X29wdHMpOwotCWlm
IChlcnIpCi0JCWdvdG8gZmFpbDsKLQotCXRyYWNlZnNfYXBwbHlfb3B0aW9ucyhzYiwgdHJ1ZSk7
Ci0KLWZhaWw6Ci0JcmV0dXJuIGVycjsKKwlyZXR1cm4gdHJhY2Vmc19wYXJzZV9vcHRpb25zKGRh
dGEsICZmc2ktPm1vdW50X29wdHMpOwogfQogCiBzdGF0aWMgaW50IHRyYWNlZnNfc2hvd19vcHRp
b25zKHN0cnVjdCBzZXFfZmlsZSAqbSwgc3RydWN0IGRlbnRyeSAqcm9vdCkKQEAgLTM5OSw4ICsy
ODEsMzMgQEAgc3RhdGljIHZvaWQgdHJhY2Vmc19kZW50cnlfaXB1dChzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnksIHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAJaXB1dChpbm9kZSk7CiB9CiAKK3N0YXRpYyBp
bnQgdHJhY2Vmc19kX3JldmFsaWRhdGUoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCB1bnNpZ25lZCBp
bnQgZmxhZ3MpCit7CisJc3RydWN0IHRyYWNlZnNfZnNfaW5mbyAqZnNpID0gZGVudHJ5LT5kX3Ni
LT5zX2ZzX2luZm87CisJc3RydWN0IHRyYWNlZnNfbW91bnRfb3B0cyAqb3B0cyA9ICZmc2ktPm1v
dW50X29wdHM7CisJc3RydWN0IGlub2RlICppbm9kZTsKKworCXJjdV9yZWFkX2xvY2soKTsKKwlp
bm9kZSA9IGRfaW5vZGVfcmN1KGRlbnRyeSk7CisJaWYgKGlub2RlKSB7CisJCWlmIChvcHRzLT5v
cHRzICYgQklUKE9wdF9tb2RlKSkgeworCQkJdW1vZGVfdCB0bXBfbW9kZTsKKwkJCXRtcF9tb2Rl
ID0gUkVBRF9PTkNFKGlub2RlLT5pX21vZGUpICYgflNfSUFMTFVHTzsKKwkJCXRtcF9tb2RlIHw9
IG9wdHMtPm1vZGU7CisJCQlXUklURV9PTkNFKGlub2RlLT5pX21vZGUsIHRtcF9tb2RlKTsKKwkJ
fQorCQlpZiAob3B0cy0+b3B0cyAmIEJJVChPcHRfdWlkKSkKKwkJCWlub2RlLT5pX3VpZCA9IG9w
dHMtPnVpZDsKKwkJaWYgKG9wdHMtPm9wdHMgJiBCSVQoT3B0X2dpZCkpCisJCQlpbm9kZS0+aV9n
aWQgPSBvcHRzLT5naWQ7CisJfQorCXJjdV9yZWFkX3VubG9jaygpOworCXJldHVybiAwOworfQor
CiBzdGF0aWMgY29uc3Qgc3RydWN0IGRlbnRyeV9vcGVyYXRpb25zIHRyYWNlZnNfZGVudHJ5X29w
ZXJhdGlvbnMgPSB7CiAJLmRfaXB1dCA9IHRyYWNlZnNfZGVudHJ5X2lwdXQsCisJLmRfcmV2YWxp
ZGF0ZSA9IHRyYWNlZnNfZF9yZXZhbGlkYXRlLAogfTsKIAogc3RhdGljIGludCB0cmFjZV9maWxs
X3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHZvaWQgKmRhdGEsIGludCBzaWxlbnQpCkBA
IC00MjcsOCArMzM0LDYgQEAgc3RhdGljIGludCB0cmFjZV9maWxsX3N1cGVyKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIHZvaWQgKmRhdGEsIGludCBzaWxlbnQpCiAJc2ItPnNfb3AgPSAmdHJhY2Vm
c19zdXBlcl9vcGVyYXRpb25zOwogCXNiLT5zX2Rfb3AgPSAmdHJhY2Vmc19kZW50cnlfb3BlcmF0
aW9uczsKIAotCXRyYWNlZnNfYXBwbHlfb3B0aW9ucyhzYiwgZmFsc2UpOwotCiAJcmV0dXJuIDA7
CiAKIGZhaWw6Cg==
--0000000000004080e0060e11aa81--

