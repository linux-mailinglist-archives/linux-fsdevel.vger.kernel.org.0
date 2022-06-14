Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2635054BC4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiFNUwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358310AbiFNUw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:52:27 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE44F9F6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 13:51:39 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so8370605fac.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RGAdkjxIXJg+0+B+nkHeGHsO8ZAxwuJMEt5nBIQXQi4=;
        b=z8XbfANxfef8zCOjgMw6n0IEGLtNAnAK9fU4Tvz8GFdyGKJ3Qh2Wbnphdf1Wa+QjB2
         RxxdvKQR6Dwd9N+WMRBSfggYLc+30bhyA30WaRPkCmeNPxXXhSPS81jWvxssBT3mk78m
         8NPvEOpCrYvVdHRwq1e3gHw1Y9XzdAy2t5+JgYxCLkb6g5HAXFCP0s89Hb++2L//Ndy9
         9AILcrkbnuxfez407sm0U0pDXO1CIYvWyv4hwEE1MinAD6dLYIo4LDFAxOBRdbi/ilIL
         cjF0WMGSHJXPly1lnpb/yEWryQ2oIQMAYpIj4IjFG4M8sDcDRid3qIt2XeWffTxNiGHG
         spcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RGAdkjxIXJg+0+B+nkHeGHsO8ZAxwuJMEt5nBIQXQi4=;
        b=Cp9d/oDmRSQtTw5IBbqs04J7HwieGaxXaINJbu/K4gOF4GSmTclpfgzHvQ8ZJ4W3qM
         lmZm8hatrPnXH12KywLxoRzOwE32VSRTUDVF1I93vh9Os5CVKe9qyOxzZW7SV3vtGI1J
         ldGCaTs+NGPG7ig/Prpb6Pf8RB14b6lpkNbD6oytysKGrTByhR++Kyj5IY+BocIY5Vc7
         iaGrbprDKrAI1t58+QcP6dOzRBtqQgL+fxNs0wuLTwab84UmiQihmRKfvNbtfrrq1inV
         XV/Fc66XS0SCA2F7OR5kJ6lOiMe6XPe7ZU973xDsuTSSnCsODnyJ45ejrrx5ag+buozq
         wgbA==
X-Gm-Message-State: AJIora8w4ta0pb119NfhoATsaIEn7mfasljD/5zWlaLyez7gLPNwL2Xg
        TJ7pkB7cMaM5tOr0Z9mCQhQAspy6s8k2lsnJJOEnpPV/m5ca6Q==
X-Google-Smtp-Source: AGRyM1toDzc7vrHco5eSKSVBFtfOY2v3t2qxnagaRr76i8DW9Rdyn4pQiObZ4yjSNL7E9HSIUsK0aDPY8i6TWc3xFes=
X-Received: by 2002:a05:6871:686:b0:f8:85a9:9268 with SMTP id
 l6-20020a056871068600b000f885a99268mr3553834oao.219.1655239898228; Tue, 14
 Jun 2022 13:51:38 -0700 (PDT)
MIME-Version: 1.0
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Date:   Tue, 14 Jun 2022 13:51:27 -0700
Message-ID: <CALP4L7TLME-ZqOBK_k-voFbiym5PdWga_1iPGTqOu8ac0=DD0g@mail.gmail.com>
Subject: Apply commit "9p: missing chunk of fs/9p: Don't update file type when
 updating file attributes" to stable
To:     stable <stable@vger.kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Please apply upstream commit b577d0cd2104 ("9p: missing chunk of
"fs/9p: Don't update file type when updating file attributes"") to
stable versions v4.9, v4.14, v4.19, v5.4, and v5.10.

It fixes an issue found by syzbot:
https://syzkaller.appspot.com/bug?id=7830d7214570b38391194d814a625dbbfd569eb4
The commit applies cleanly to all the versions listed above.
Please also add:
Reported-by: syzbot+16342c5db3ef64c0f60a@syzkaller.appspotmail.com
Tested-by: Tadeusz Struk <tadeusz.struk@linaro.org>

Thanks,
Tadeusz
