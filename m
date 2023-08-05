Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80897770DCE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 06:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjHEE5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 00:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEE5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:57:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058604ED3;
        Fri,  4 Aug 2023 21:57:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-563de62f861so1580767a12.1;
        Fri, 04 Aug 2023 21:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691211435; x=1691816235;
        h=subject:reply-to:content-language:cc:to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQvwEdX9TBr9o+EckKmYGe1U7wS/eabk61QQqb82cfA=;
        b=kn0fkjvFsTxWFQJolGTwW1if3Yzo/h77LOHnFxcwLgzSjVWgCX2H9SGJaEbbfS5XKi
         d9+y291rxEyUcfFjWZ5ujUQEtspD7KgFDDNx5aD0f9yKefVFvLoUNwkJQCY5+EhGxSVD
         JPRtczdhoX2kvgBuxHu9znc8Sz/VTbyMOV96db5u8QEV6bv0ZHZxMItALrlq+hEs04W2
         KKvkdhz2zkF9DVeXgw3yfnVhPJtew7eRHqAU5IcNfK0+8k29dlBnqSGZy0pvpPI8acqc
         qIfVVAKJwDZodh6Ae+g82QdD2xeZIa22vmJdhZab2dRH8WPEcuL9mFRNvGhzKu+QzxCX
         dE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691211435; x=1691816235;
        h=subject:reply-to:content-language:cc:to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dQvwEdX9TBr9o+EckKmYGe1U7wS/eabk61QQqb82cfA=;
        b=L4wKd643GmoRoyCUgMA74Q3IUl7KwzkmPHdk8o1s85M7GmX0WJMJoFlbfH+1VhtW9a
         9A3PitstNHfkycjmM6oJp7T2wcE1eARSHUaZBEVYnFNoIBj3boAGULSq/CTdIT4CpGxn
         DwAsUsfjZ5lhOCq3iEcVWdzFG9YxkQq0JCNZsR1ZwYPqvfXnqyxASBV3rSZn8PkiNXuL
         3OIfCMUbudBP2/hTVnc0UQzoDwmjvDiFGKod7ItJXh2UTpi3VKWrFgjfhHDPYZKADCGk
         Ll9LEZrKcIVdcovImDKnF+O+6lyP9e750GOHHTIBD7qRNZoHnus6y6b5BcqVR2DFanPu
         Ea0A==
X-Gm-Message-State: AOJu0YxYrluxRguFKhOyKOxUxLihuQwsmxWi8rKZZ/TedjSVsRbc7mVq
        0MPoESIXPyNdIaQrA8+FNcY=
X-Google-Smtp-Source: AGHT+IG2u1qBiLgaRvn0xQRB3FoCYjWpMhuAdJDrCx3FzwDcx3e7VY7JDb5EqsEvy1lMa40LrNN0Bg==
X-Received: by 2002:a17:902:cec7:b0:1bb:3979:d467 with SMTP id d7-20020a170902cec700b001bb3979d467mr4446443plg.63.1691211435378;
        Fri, 04 Aug 2023 21:57:15 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001b9c5e0393csm2555482plb.225.2023.08.04.21.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 21:57:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------oihDkra1NslgCm8MY9XksS30"
Message-ID: <913c36b5-f651-c728-7322-fe648d614a66@gmail.com>
Date:   Sat, 5 Aug 2023 10:27:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     "syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com" 
        <syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com>
Cc:     anton@tuxera.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Language: en-US
Reply-To: 0000000000000424f205fcf9a132@google.com
Subject: [syzbot] [ntfs?] UBSAN: shift-out-of-bounds in ntfs_iget
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------oihDkra1NslgCm8MY9XksS30
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

In this bug, the logic at the following line 
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ntfs/inode.c?id=e8f75c0270d930ef675fee22d74d1a3250e96962#n1067) 
is getting skipped. The `if` condition is not triggered and thus the 
compression issue occurs. I was trying to change the `if` conditions so 
that the check occurs but was getting the following error. Can you 
suggest any way so that the condition gets triggered.

Thanks,
Manas

--------------oihDkra1NslgCm8MY9XksS30
Content-Type: text/plain; charset=UTF-8; name="trace"
Content-Disposition: attachment; filename="trace"
Content-Transfer-Encoding: base64

CkJvb3RpbmcgZnJvbSBST00uLgpbICAgIDAuMDAwMDAwXVsgICAgVDBdIExpbnV4IHZlcnNp
b24gNi40LjAtMDE0MDYtZ2U4Zjc1YzAyNzBkOS1kaXJ0eSAobWFuYXNAbWFuYXMtVmlydHVh
bEJveCkgKGdjYyAoVWJ1bnR1IDEyLjIuMC0zdWJ1bnR1MSkgMTIuMi4wLCBHTlUgbGQgKEdO
VSBCaW51dGlscyBmb3IgVWJ1bnR1KSAyLjM5KSAjOCBTTVAgUFJFRU1QVF9EWU5BTUlDIFNh
dCBBdWcgIDUgMDk6MDg6MjUgSVNUIDIwMjMKWyAgICAwLjAwMDAwMF1bICAgIFQwXSBDb21t
YW5kIGxpbmU6IHJvb3Q9L2Rldi9yYW0gcncgY29uc29sZT10dHlTMCBvb3BzPXBhbmljIHBh
bmljPTEgbm9rYXNsciBxdWlldApbICAgIDAuMDAwMDAwXVsgICAgVDBdIEtFUk5FTCBzdXBw
b3J0ZWQgY3B1czoKWyAgICAwLjAwMDAwMF1bICAgIFQwXSAgIEludGVsIEdlbnVpbmVJbnRl
bApbICAgIDAuMDAwMDAwXVsgICAgVDBdICAgQU1EIEF1dGhlbnRpY0FNRApbICAgIDAuMDAw
MDAwXVsgICAgVDBdIEJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoKWyAgICAwLjAw
MDAwMF1bICAgIFQwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAw
MDAwMDAwMDA5ZmJmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdWyAgICBUMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDAwMDA5ZmMwMC0weDAwMDAwMDAwMDAwOWZmZmZdIHJlc2VydmVk
ClsgICAgMC4wMDAwMDBdWyAgICBUMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDBm
MDAwMC0weDAwMDAwMDAwMDAwZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdWyAgICBU
MF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAwN2ZmZGZm
ZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXVsgICAgVDBdIEJJT1MtZTgyMDogW21lbSAweDAw
MDAwMDAwN2ZmZTAwMDAtMHgwMDAwMDAwMDdmZmZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAw
MDAwXVsgICAgVDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVmZmMwMDAtMHgwMDAw
MDAwMGZlZmZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXVsgICAgVDBdIEJJT1MtZTgy
MDogW21lbSAweDAwMDAwMDAwZmZmYzAwMDAtMHgwMDAwMDAwMGZmZmZmZmZmXSByZXNlcnZl
ZApbICAgIDAuMDAwMDAwXVsgICAgVDBdIHByaW50azogYm9vdGNvbnNvbGUgW2Vhcmx5c2Vy
MF0gZW5hYmxlZApbICAgIDAuMDAwMDAwXVsgICAgVDBdIEVSUk9SOiBlYXJseXByaW50az0g
ZWFybHlzZXIgYWxyZWFkeSB1c2VkClsgICAgMC4wMDAwMDBdWyAgICBUMF0gRVJST1I6IGVh
cmx5cHJpbnRrPSBlYXJseXNlciBhbHJlYWR5IHVzZWQKWyAgICAwLjAwMDAwMF1bICAgIFQw
XSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqClsgICAgMC4wMDAwMDBdWyAgICBUMF0gKiogICBOT1RJQ0UgTk9USUNFIE5PVElD
RSBOT1RJQ0UgTk9USUNFIE5PVElDRSBOT1RJQ0UgICAqKgpbICAgIDAuMDAwMDAwXVsgICAg
VDBdICoqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKioKWyAgICAwLjAwMDAwMF1bICAgIFQwXSAqKiBUaGlzIHN5c3RlbSBzaG93cyB1
bmhhc2hlZCBrZXJuZWwgbWVtb3J5IGFkZHJlc3NlcyAgICoqClsgICAgMC4wMDAwMDBdWyAg
ICBUMF0gKiogdmlhIHRoZSBjb25zb2xlLCBsb2dzLCBhbmQgb3RoZXIgaW50ZXJmYWNlcy4g
VGhpcyAgICAqKgpbICAgIDAuMDAwMDAwXVsgICAgVDBdICoqIG1pZ2h0IHJlZHVjZSB0aGUg
c2VjdXJpdHkgb2YgeW91ciBzeXN0ZW0uICAgICAgICAgICAgKioKWyAgICAwLjAwMDAwMF1b
ICAgIFQwXSAqKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICoqClsgICAgMC4wMDAwMDBdWyAgICBUMF0gKiogSWYgeW91IHNlZSB0aGlz
IG1lc3NhZ2UgYW5kIHlvdSBhcmUgbm90IGRlYnVnZ2luZyAgICAqKgpbICAgIDAuMDAwMDAw
XVsgICAgVDBdICoqIHRoZSBrZXJuZWwsIHJlcG9ydCB0aGlzIGltbWVkaWF0ZWx5IHRvIHlv
dXIgc3lzdGVtICAgKioKWyAgICAwLjAwMDAwMF1bICAgIFQwXSAqKiBhZG1pbmlzdHJhdG9y
ISAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoqClsgICAgMC4wMDAw
MDBdWyAgICBUMF0gKiogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqKgpbICAgIDAuMDAwMDAwXVsgICAgVDBdICoqICAgTk9USUNFIE5P
VElDRSBOT1RJQ0UgTk9USUNFIE5PVElDRSBOT1RJQ0UgTk9USUNFICAgKioKWyAgICAwLjAw
MDAwMF1bICAgIFQwXSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqClsgICAgMC4wMDAwMDBdWyAgICBUMF0gTWFsZm9ybWVkIGVh
cmx5IG9wdGlvbiAndnN5c2NhbGwnClsgICAgMC42NDg0MzRdWyAgICBUMF0gU3BlY3RyZSBW
MiA6IEtlcm5lbCBub3QgY29tcGlsZWQgd2l0aCByZXRwb2xpbmU7IG5vIG1pdGlnYXRpb24g
YXZhaWxhYmxlIQpbICAgIDIuNjEyNDIyXVsgICAgVDFdIGt2bV9pbnRlbDogVk1YIG5vdCBz
dXBwb3J0ZWQgYnkgQ1BVIDAKWyAgICAyLjYxNTcyMF1bICAgIFQxXSBrdm1fYW1kOiBTVk0g
bm90IHN1cHBvcnRlZCBieSBDUFUgMCwgY2FuJ3QgZXhlY3V0ZSBjcHVpZF84MDAwMDAwYQpb
ICAgIDYuMDg0MzM5XVsgICAgVDFdIGRiX3Jvb3Q6IGNhbm5vdCBvcGVuOiAvZXRjL3Rhcmdl
dApbICAgIDguNzU2OTMwXVsgICAgVDFdIG5mX2Nvbm50cmFja19pcmM6IGZhaWxlZCB0byBy
ZWdpc3RlciBoZWxwZXJzClsgICAgOC43NjM4NjNdWyAgICBUMV0gbmZfY29ubnRyYWNrX3Nh
bmU6IGZhaWxlZCB0byByZWdpc3RlciBoZWxwZXJzClsgICAgOC44Nzc3MDRdWyAgICBUMV0g
bmZfY29ubnRyYWNrX3NpcDogZmFpbGVkIHRvIHJlZ2lzdGVyIGhlbHBlcnMKWyAgIDEwLjE1
NzY4Ml1bICAgIFQxXSBleEZBVC1mcyAocmFtMCk6IGludmFsaWQgZnNfbmFtZQpbICAgMTAu
MTU4ODA1XVsgICAgVDFdIGV4RkFULWZzIChyYW0wKTogZmFpbGVkIHRvIHJlYWQgYm9vdCBz
ZWN0b3IKWyAgIDEwLjE1OTk3N11bICAgIFQxXSBleEZBVC1mcyAocmFtMCk6IGZhaWxlZCB0
byByZWNvZ25pemUgZXhmYXQgdHlwZQpbICAgMTAuMTY2ODM2XVsgICAgVDFdIFZGUzogY291
bGQgbm90IGZpbmQgYSB2YWxpZCBWNyBvbiByYW0wLgpbICAgMTAuMTcwMTM3XVsgICAgVDFd
IG50ZnM6IChkZXZpY2UgcmFtMCk6IG50ZnNfYXR0cl9maW5kKCk6IElub2RlIGlzIGNvcnJ1
cHQuICBSdW4gY2hrZHNrLgpbICAgMTAuMTcxNzMzXVsgICAgVDFdIG50ZnM6IChkZXZpY2Ug
cmFtMCk6IG50ZnNfcmVhZF9sb2NrZWRfaW5vZGUoKTogRmFpbGVkIHRvIGxvb2t1cCAkREFU
QSBhdHRyaWJ1dGUuClsgICAxMC4xNzM0MzldWyAgICBUMV0gbnRmczogKGRldmljZSByYW0w
KTogbnRmc19yZWFkX2xvY2tlZF9pbm9kZSgpOiBGYWlsZWQgd2l0aCBlcnJvciBjb2RlIC01
LiAgTWFya2luZyBjb3JydXB0IGlub2RlIDB4MSBhcyBiYWQuICBSdW4gY2hrZHNrLgpbICAg
MTAuMTc1ODE1XVsgICAgVDFdIG50ZnM6IChkZXZpY2UgcmFtMCk6IGxvYWRfc3lzdGVtX2Zp
bGVzKCk6IEZhaWxlZCB0byBsb2FkICRNRlRNaXJyLiAgTW91bnRpbmcgcmVhZC1vbmx5LiAg
UnVuIG50ZnNmaXggYW5kL29yIGNoa2Rzay4KWyAgIDEwLjE3ODY4NF1bICAgIFQxXSBudGZz
OiAoZGV2aWNlIHJhbTApOiBudGZzX21hcHBpbmdfcGFpcnNfZGVjb21wcmVzcygpOiBNaXNz
aW5nIGxlbmd0aCBlbnRyeSBpbiBtYXBwaW5nIHBhaXJzIGFycmF5LgpbICAgMTAuMTgwODg2
XVsgICAgVDFdIG50ZnM6IChkZXZpY2UgcmFtMCk6IG50ZnNfbWFwcGluZ19wYWlyc19kZWNv
bXByZXNzKCk6IEludmFsaWQgbGVuZ3RoIGluIG1hcHBpbmcgcGFpcnMgYXJyYXkuClsgICAx
MC4xODI4MDRdWyAgICBUMV0gbnRmczogKGRldmljZSByYW0wKTogbnRmc19yZWFkX2Jsb2Nr
KCk6IEZhaWxlZCB0byByZWFkIGZyb20gaW5vZGUgMHhhLCBhdHRyaWJ1dGUgdHlwZSAweDgw
LCB2Y24gMHgwLCBvZmZzZXQgMHgwIGJlY2F1c2UgaXRzIGxvY2F0aW9uIG9uIGRpc2sgY291
bGQgbm90IGJlIGRldGVybWluZWQgZXZlbiBhZnRlciByZXRyeWluZyAoZXJyb3IgY29kZSAt
NSkuClsgICAxMC4xODY0MTBdWyAgICBUMV0gbnRmczogKGRldmljZSByYW0wKTogbnRmc19t
YXBwaW5nX3BhaXJzX2RlY29tcHJlc3MoKTogTWlzc2luZyBsZW5ndGggZW50cnkgaW4gbWFw
cGluZyBwYWlycyBhcnJheS4KWyAgIDEwLjE4ODQ4NV1bICAgIFQxXSBudGZzOiAoZGV2aWNl
IHJhbTApOiBudGZzX21hcHBpbmdfcGFpcnNfZGVjb21wcmVzcygpOiBJbnZhbGlkIGxlbmd0
aCBpbiBtYXBwaW5nIHBhaXJzIGFycmF5LgpbICAgMTAuMTkwNDExXVsgICAgVDFdIG50ZnM6
IChkZXZpY2UgcmFtMCk6IG50ZnNfcmVhZF9ibG9jaygpOiBGYWlsZWQgdG8gcmVhZCBmcm9t
IGlub2RlIDB4YSwgYXR0cmlidXRlIHR5cGUgMHg4MCwgdmNuIDB4MCwgb2Zmc2V0IDB4ODAw
IGJlY2F1c2UgaXRzIGxvY2F0aW9uIG9uIGRpc2sgY291bGQgbm90IGJlIGRldGVybWluZWQg
ZXZlbiBhZnRlciByZXRyeWluZyAoZXJyb3IgY29kZSAtNSkuClsgICAxMC4zMTM0NjVdWyAg
ICBUMV0gRmFpbGVkIHRvIHNldCBzeXNjdGwgcGFyYW1ldGVyICdtYXhfcmN1X3N0YWxsX3Rv
X3BhbmljPTEnOiBwYXJhbWV0ZXIgbm90IGZvdW5kClsgICAxMC4zMTYyMThdWyAgICBUMV0g
U3RhcnRpbmcgaW5pdDogL3NiaW4vaW5pdCBleGlzdHMgYnV0IGNvdWxkbid0IGV4ZWN1dGUg
aXQgKGVycm9yIC01KQpbICAgMTAuMzE4MjY4XVsgICAgVDFdIFN0YXJ0aW5nIGluaXQ6IC9l
dGMvaW5pdCBleGlzdHMgYnV0IGNvdWxkbid0IGV4ZWN1dGUgaXQgKGVycm9yIC01KQpbICAg
MTAuMzIwMDQ3XVsgICAgVDFdIFN0YXJ0aW5nIGluaXQ6IC9iaW4vaW5pdCBleGlzdHMgYnV0
IGNvdWxkbid0IGV4ZWN1dGUgaXQgKGVycm9yIC01KQpbICAgMTAuMzIxODk1XVsgICAgVDFd
IFN0YXJ0aW5nIGluaXQ6IC9iaW4vc2ggZXhpc3RzIGJ1dCBjb3VsZG4ndCBleGVjdXRlIGl0
IChlcnJvciAtNSkKWyAgIDEwLjMyMzQxMF1bICAgIFQxXSBLZXJuZWwgcGFuaWMgLSBub3Qg
c3luY2luZzogTm8gd29ya2luZyBpbml0IGZvdW5kLiAgVHJ5IHBhc3NpbmcgaW5pdD0gb3B0
aW9uIHRvIGtlcm5lbC4gU2VlIExpbnV4IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaW5p
dC5yc3QgZm9yIGd1aWRhbmNlLgpbICAgMTAuMzI2MTgxXVsgICAgVDFdIENQVTogMCBQSUQ6
IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDYuNC4wLTAxNDA2LWdlOGY3NWMwMjcw
ZDktZGlydHkgIzgKWyAgIDEwLjMyNzc4MV1bICAgIFQxXSBIYXJkd2FyZSBuYW1lOiBRRU1V
IFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE2LjAtZGViaWFu
LTEuMTYuMC00IDA0LzAxLzIwMTQKWyAgIDEwLjMyNzc4MV1bICAgIFQxXSBDYWxsIFRyYWNl
OgpbICAgMTAuMzI3NzgxXVsgICAgVDFdICA8VEFTSz4KWyAgIDEwLjMyNzc4MV1bICAgIFQx
XSAgZHVtcF9zdGFja19sdmwrMHhkOS8weDFiMApbICAgMTAuMzI3NzgxXVsgICAgVDFdICBw
YW5pYysweDZhNC8weDc1MApbICAgMTAuMzI3NzgxXVsgICAgVDFdICA/IHBhbmljX3NtcF9z
ZWxmX3N0b3ArMHhhMC8weGEwClsgICAxMC4zMjc3ODFdWyAgICBUMV0gID8gcHV0bmFtZSsw
eDEwMS8weDE0MApbICAgMTAuMzI3NzgxXVsgICAgVDFdICA/IGtlcm5lbF9pbml0KzB4MjY1
LzB4MmEwClsgICAxMC4zMjc3ODFdWyAgICBUMV0gIGtlcm5lbF9pbml0KzB4Mjc2LzB4MmEw
ClsgICAxMC4zMjc3ODFdWyAgICBUMV0gID8gcmVzdF9pbml0KzB4MmIwLzB4MmIwClsgICAx
MC4zMjc3ODFdWyAgICBUMV0gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwClsgICAxMC4zMjc3
ODFdWyAgICBUMV0gIDwvVEFTSz4KWyAgIDEwLjMyNzc4MV1bICAgIFQxXSBLZXJuZWwgT2Zm
c2V0OiBkaXNhYmxlZApbICAgMTAuMzI3NzgxXVsgICAgVDFdIFJlYm9vdGluZyBpbiAxIHNl
Y29uZHMuLgo=

--------------oihDkra1NslgCm8MY9XksS30--
