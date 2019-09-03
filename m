Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C142A71DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 19:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfICRkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 13:40:14 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:42247
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729751AbfICRkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567532408; bh=4M08xijWsFj+wrPz9IhAs5Zc9q4VQYH7Y0E6dN4LNIg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mb4mrOXRn9KmAFASJt2YrI04R3x6WIARTENTq9eG460DfRSjRmo0O0iw0dVA3mdn1xy5i0K+Ue3fR46ifVJSvRBs3+tq0zObG+VBPfkGon4/zhP4DCvMRG39W+ikBXMXYVg2izJg8y9u1uudDvQDlzFLpYLrUVpiNfFLGFygwPvb9bi9b6OC0WM/gjYaH7jspq5/Z8iHcbaLORWyI3woVw6BPH+5Od5A/ln7tjPTQ0lMVQqxdLvEhOVzHRV6dkG6iYIQjLqfIu/fjggP0sJ03JWWdf18sR6jhkDAOloL2p01sR8O2owt0jbMTNydDMilYndA3BziIjyF03tS/AbnEA==
X-YMail-OSG: YDxtC3QVM1n85oqA3rTc6see1L.LLaZGwQh8Sj3WYSsQzSscFKYm.8QJM3bhztn
 vZieAFueMmsq3an1iDc8P0gsCNJTgG0COBcqtPjrRdvjdIHKd_gS19_TnSgRciiGq39w8KWzHDgQ
 dxNjoVuHDCIH6t6RDYn0H6Un3_eZzyNf3rEQczlefq_WLO.zccz010vmS7NtjYF5rlFbEW6vW13X
 tj9gAhi4TUscN03JutrbhKzVZbO0jWRoMbp2oRWNXdduD7Q33pE9qI8FIWsAEsOOv.QIByKdsrPQ
 6SEolJZIO9QZD5mnBPzce04QzDKW_QA8svJ_y1uJadbanNj9sYR7XkGE4PpbMtO3J2Y30VZXZd9p
 SZvTtXM9zLhlcPIqGeoeZ1PPO3Ro50.9Fxi7GNhZAL1qIAQ_tYTptOiWO40fAD1zUdjGsfIoT9H8
 RFEiaYxjd4zKLo40N0wxiUgAqt9_Vy3rsQDJMiyNqlzT1.TG3VKGGsy_uNbMoFoPwNTdzMY6eV7F
 Izise7j3liWbLjXsfHaNI51fgXHVLheu88wbxZgW2Zt9W0sdZhoMwVd_ap3SAmwh0AnZ8HCSFtH3
 _LysYMQaF.hUivnA75rhL0waQZrve.2ZcjyXBhTsz4PKrbg1htcMcWM14e9GcbIs1J31kILno011
 Vi3DyJsD34r4Tp92ovGBPot0rV.cigY2PvsSOe2Sf4xn.cwjOazOgjc4fDEsbhZPutiZ8XkfBidL
 kuBXT2JRkSZJCRbuMAOPXyZiZq9k4ZexP6cuTjmsy.o3Hs8fSgOypcByqQlgldDhI.ctU8lzTHzx
 dAwBOBOWIxZe75iDqMErkPmtY97D_0SG7u8l35NlNGSshAbHSCDzGrcJDgp224nj1IxlRgsF98uf
 4gQluf.7rzcSzQTahvH_kXbPrm_Bx0TopJha_6vSbHh2qwnxm5mMf83LwIlCiekcCQD051isXGKt
 t5JiECh9c6S67ifPjMeohk8B_tifURgQkiYbmMyZTuyPSTi5I9blGXdL3IQwLGRcOSva4Ain5HKy
 HiO.eVyZRWyoHk5k2PJB_YNg5umfeJx.hfo8fxDEMK7yRRLYhoAWG51tuTTk5czDSKQCe63_wleu
 I9vTzZaccC7ltHkxSkmskn69PASq010MK533p0yQmto5XE1REbQU56dEVlx46gYhooF1dj0Kep9B
 50xLxtx0Sf7ONabb5MG7yMAmJAQD.der9CrGAQN4L2Rkz8ohatw2I5AycP86tLydKilrzjWNL._D
 VrWVnj5JaJNj5RJ.KqbtKf8hhrD_GgJi73CWbekbcyiPKhpmQthoz0nanCS0ySqfH
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Sep 2019 17:40:08 +0000
Received: by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5ea2e0d4519e45f788c8eceafbe81aed;
          Tue, 03 Sep 2019 17:40:06 +0000 (UTC)
Subject: Re: [PATCH 11/11] smack: Implement the watch_key and
 post_notification hooks [untested] [ver #7]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <e36fa722-a300-2abf-ae9c-a0246fc66d0e@schaufler-ca.com>
 <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717352917.2204.17206219813087348132.stgit@warthog.procyon.org.uk>
 <4910.1567525310@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <87bf0363-af77-1e5a-961f-72730e39e3a6@schaufler-ca.com>
Date:   Tue, 3 Sep 2019 10:40:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4910.1567525310@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/3/2019 8:41 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> I tried running your key tests and they fail in "keyctl/move/valid",
>> with 11 FAILED messages, finally hanging after "UNLINK KEY FROM SESSION".
>> It's possible that my Fedora26 system is somehow incompatible with the
>> tests. I don't see anything in your code that would cause this, as the
>> Smack policy on the system shouldn't restrict any access.
> Can you go into keyutils/tests/keyctl/move/valid/ and grab the test.out file?

Inline below

> I presume you're running with an upstream-ish kernel

Built from your tree. It's possible I've missed an important
CONFIG or two.

>  and a cutting edge
> keyutils installed?

Also built from your tree. 

>
> David

$ cat test.out
++++ BEGINNING TEST
+++ ADD KEYRING
keyctl newring wibble @s
1065401533
+++ ADD KEY
keyctl add user lizard gizzard 1065401533
483362336
+++ LIST KEYRING WITH ONE
keyctl rlist 1065401533
483362336
+++ MOVE KEY 1
keyctl move 483362336 1065401533 @s
keyctl_move: Operation not supported
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0       \_ user: lizard
==============
+++ CHECK KEY LINKAGE
keyctl rlist @s
1065401533
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0       \_ user: lizard
==============
+++ CHECK KEY REMOVED
keyctl rlist 1065401533
483362336
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0       \_ user: lizard
==============
+++ MOVE KEY 2
keyctl move 483362336 1065401533 @s
keyctl_move: Operation not supported
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0       \_ user: lizard
==============
+++ FORCE MOVE KEY 2
keyctl move -f 483362336 1065401533 @s
keyctl_move: Operation not supported
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0       \_ user: lizard
==============
+++ MOVE KEY 3
keyctl move 483362336 @s 1065401533
keyctl_move: Operation not supported
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0       \_ user: lizard
==============
+++ MOVE KEY 4
keyctl move -f 483362336 @s 1065401533
keyctl_move: Operation not supported
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0       \_ user: lizard
==============
+++ ADD KEY 2
keyctl add user lizard gizzard @s
898499184
+++ MOVE KEY 5
keyctl move 483362336 1065401533 @s
keyctl_move: Operation not supported
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0   |   \_ user: lizard
 898499184 --alswrv      0     0   \_ user: lizard
==============
+++ CHECK KEY UNMOVED
keyctl rlist 1065401533
483362336
+++ CHECK KEY UNDISPLACED
keyctl rlist @s
1065401533 898499184
+++ FORCE MOVE KEY 6
keyctl move -f 483362336 1065401533 @s
keyctl_move: Operation not supported
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0   |   \_ user: lizard
 898499184 --alswrv      0     0   \_ user: lizard
==============
+++ CHECK KEY REMOVED
keyctl rlist 1065401533
483362336
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0   |   \_ user: lizard
 898499184 --alswrv      0     0   \_ user: lizard
==============
+++ CHECK KEY DISPLACED
keyctl rlist @s
1065401533 898499184
=== FAILED ===
Session Keyring
 680859405 --alswrv      0     0  keyring: RHTS/keyctl/32472
1065401533 --alswrv      0     0   \_ keyring: wibble
 483362336 --alswrv      0     0   |   \_ user: lizard
 898499184 --alswrv      0     0   \_ user: lizard
==============
+++ UNLINK KEY FROM SESSION
keyctl unlink 483362336 @s
+++ WAITING FOR KEY TO BE UNLINKED
keyctl unlink 483362336 @s
keyctl_unlink: No such file or directory
keyctl unlink 483362336 @s
keyctl_unlink: No such file or directory

...

