Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC150752A46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGMSYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:24:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583432D47;
        Thu, 13 Jul 2023 11:24:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso1847343e87.1;
        Thu, 13 Jul 2023 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689272658; x=1691864658;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZM9IKkzNQVcX/YPOWYv1qyHnYAChxmvUSggSWR8eOo=;
        b=XEWifCyJZdiO8NJzQJHJBV8lj/qKPWni5Z48P740idijiZM9UzUBmXI6x8lhHyBmcS
         YW7R86YG4trdvBLSuN21heQVvNet/wwz3pqdyvSxxJzXB247EkNvORqObe8PSHu9/Lh3
         eMj5dIhhg3QLwvjsAtkqTBfxZj8A7okc4cymthM6W4+10Ydfu+v90DNvKlMCbCkn4mS4
         xCGCRqz1hXeIA+3nZD2X/OQX3VxqBlmyjlFr51enTpz0iRRCOufb+rySC+LD4dfl8fe4
         JlHr1AuGHGOfTwyj89W3k3ciuHvy2nwt5TrX9DxA8Bglqu6yDwop2aG3VZcn08Vos3jB
         +8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689272658; x=1691864658;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ZM9IKkzNQVcX/YPOWYv1qyHnYAChxmvUSggSWR8eOo=;
        b=IcPyF87X0e2EtDAQTOu7Dj8EaJLOLMpqMgXlEizmey+bJ/b9nLCqmJmbrMDiFEYn2x
         wcm8CePOsyN26h67LAo67raJt9AN/eR9T79GtCmZrRjzuBqL1ZzPakyU3cvk3BNqsJPj
         xZ3g+soBbTfzVncJtOio1C3vJc0oukOTNu7Z8rM84fk/9qSMpgipqvv2tjk7gYpt8hzp
         bvVPdBG9dAnbGR6H2MxwM/vMI+epsU4RdCPmG8eRwMVzFV9Kf6tqGNZsbF1cy9V2Xo+6
         54BDvcr7rwerJhnWOYWp13jQOZmHz37AL0SvrSOhpFrRtyMF7XBd5tttasgEbeJR5i0s
         tX1A==
X-Gm-Message-State: ABy/qLZQskxh43ydh5GBS7kZjFPQvcY0co4PFYnTdVSnk2zOivYDdwRO
        1NFyWZTlKl/vRM5dW4ONIMo=
X-Google-Smtp-Source: APBJJlHo/B6rAzHN6EqtIhLt/a16/7UQ9pxFGEg/OM/8DXSHia5tlo8/0c3GJF1QtZA6VUQKKDH6EQ==
X-Received: by 2002:a05:6512:3d1a:b0:4f8:58ae:8ea8 with SMTP id d26-20020a0565123d1a00b004f858ae8ea8mr2007147lfv.58.1689272658182;
        Thu, 13 Jul 2023 11:24:18 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:6b00:a1a8:4887:1af4:637a? ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id v22-20020ac25596000000b004fb745fd21esm1193749lfg.122.2023.07.13.11.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 11:24:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------p02ftcxQI3q46laEXz8xbUKm"
Message-ID: <b85911af-b7e1-0ef4-b102-1bc9c602a936@gmail.com>
Date:   Thu, 13 Jul 2023 21:24:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in bcmp
Content-Language: en-US
To:     syzbot <syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com>,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
References: <0000000000009467500600449f6c@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <0000000000009467500600449f6c@google.com>
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------p02ftcxQI3q46laEXz8xbUKm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Syzbot,

Syzbot <syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com> says:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8689f4f2ea56 Merge tag 'mmc-v6.5-2' of git://git.kernel.or..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1658af44a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=15873d91ff37a949
> dashboard link: https://syzkaller.appspot.com/bug?extid=53ce40c8c0322c06aea5
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f82688a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d54a78a80000
> 

#syz test 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master





With regards,
Pavel Skripkin
--------------p02ftcxQI3q46laEXz8xbUKm
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL250ZnMzL3N1cGVyLmMgYi9mcy9udGZzMy9zdXBlci5jCmluZGV4
IDFhMDIwNzJiNmIwZS4uZTA0ZTg5YjczMzVlIDEwMDY0NAotLS0gYS9mcy9udGZzMy9zdXBl
ci5jCisrKyBiL2ZzL250ZnMzL3N1cGVyLmMKQEAgLTg1NSw2ICs4NTUsMTEgQEAgc3RhdGlj
IGludCBudGZzX2luaXRfZnJvbV9ib290KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHUzMiBz
ZWN0b3Jfc2l6ZSwKIAogY2hlY2tfYm9vdDoKIAllcnIgPSAtRUlOVkFMOworCisJLyogQ29y
cnVwdGVkIGltYWdlOyBkbyBub3QgcmVhZCBPT0IgKi8KKwlpZiAoYmgtPmJfc2l6ZSAtIHNp
emVvZigqYm9vdCkgPCBib290X29mZikKKwkJZ290byBvdXQ7CisKIAlib290ID0gKHN0cnVj
dCBOVEZTX0JPT1QgKilBZGQyUHRyKGJoLT5iX2RhdGEsIGJvb3Rfb2ZmKTsKIAogCWlmICht
ZW1jbXAoYm9vdC0+c3lzdGVtX2lkLCAiTlRGUyAgICAiLCBzaXplb2YoIk5URlMgICAgIikg
LSAxKSkgewo=

--------------p02ftcxQI3q46laEXz8xbUKm--
