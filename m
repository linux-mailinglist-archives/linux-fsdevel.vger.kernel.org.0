Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6A782EBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbjHUQr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjHUQr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:47:56 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899FCC;
        Mon, 21 Aug 2023 09:47:55 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-79969c14964so1021239241.2;
        Mon, 21 Aug 2023 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692636474; x=1693241274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjQRVQRH0MvBIBCqexCP9I4hxh2GB6Sga648A3l5Ff4=;
        b=Trc+Nuk70hE9cFyGdyaBBS4Hvt2YDyB60rzHz7DgQQFP5q9OEqhFIYNGJSaJ5srF1f
         9o2mxJJPBRG7/O5t/1hejqthljOjJAimAKmmabgQiEiBF5/d9AWiKizhLFSk1hUkLetP
         H4wQPKCeUVWddoizlXW/sjf1IzpUvEHgDRYrrN97XyjBkWzohkvw6VvoEarrc3AZ0/zo
         fDaiqvvW/ILiucOmBxVOQhnenIDs5NwPAWatx6z+YqrcnAEUCPL31bOZmr8A6XuB+62q
         976VsBd4opwBtNKfGUudUczDC2J3tg5uCG2EFGWCyTone6v6xrNxigoTuU8k5QD3fTP2
         zeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636474; x=1693241274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjQRVQRH0MvBIBCqexCP9I4hxh2GB6Sga648A3l5Ff4=;
        b=XwCgHRtP03Yqd8KU/J9xYPv8FvolrLTaKgZxLqN3d7Msvhb+nOY7w1gZK2WHQWkiQA
         dksiME2p/pscNX9woc+nItalGs0zYKusGYDQow5C1bntLT6rr7gHj9dE8BphJpuLgnt8
         qriSJ77NBr4guWmVtQbg/JvZoPaFBcv+7GyZFkXDYgLBG5i5pHtkteuBkIrIQ/dIyPaM
         8+Q0nfZ8R0lcAyLgP1Rv8FCg7ZXs+PcnhTkjz8nAA/waYbF8l3cqpRjvBXk64CLbxVwN
         enXEUcngo82AGzlMQcc/Q/LJ365mHwumIQWffdG0s9pJHqr95u5RCoCDvYvYJrLprsXD
         RZAw==
X-Gm-Message-State: AOJu0YzaaN8oxJNoNV0ntjIi4ZjHk33nocADmleII5wdU0xwbXDW8QAD
        ogvN5KXoDjgjrxnWdiII3YXyGQV0sjbb/XDrTeDKQCr+Tv8=
X-Google-Smtp-Source: AGHT+IEH/sJbSknnA+u3xgAw7xsfbnrcHN/YUsqgoiuE59HUfRjqarp49F2e9zztm1xvy/S3rdo1MWtIzPyuM/vF+JM=
X-Received: by 2002:a05:6102:354f:b0:447:55b0:bceb with SMTP id
 e15-20020a056102354f00b0044755b0bcebmr5886601vss.0.1692636474446; Mon, 21 Aug
 2023 09:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dc83d605f0c70a11@google.com> <000000000000d299b406035f1bbd@google.com>
In-Reply-To: <000000000000d299b406035f1bbd@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 22 Aug 2023 01:47:38 +0900
Message-ID: <CAKFNMo=XRe5UZeOEumfTJYRndDb0YrxhO=9261jq4aRNaPqXYg@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] kernel BUG in folio_end_writeback
To:     syzbot <syzbot+7e5cf1d80677ec185e63@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 3:41=E2=80=AFAM syzbot
<syzbot+7e5cf1d80677ec185e63@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 92c5d1b860e9581d64baca76779576c0ab0d943d
> Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Date:   Fri May 26 02:13:32 2023 +0000
>
>     nilfs2: reject devices with insufficient block count
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D170c6337a8=
0000
> start commit:   929ed21dfdb6 Merge tag '6.4-rc4-smb3-client-fixes' of git=
:..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3da6c5d3e0a6c=
932
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7e5cf1d80677ec1=
85e63
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16cb3b69280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10f3420128000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: nilfs2: reject devices with insufficient block count
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

I have confirmed that one of the five registered reproducers emits the
error message that is output when the above commit takes effect.
However, the remaining four did not.
So, I think it's premature to conclude that the issue has been fixed
by this commit at this time.

Ryusuke Konishi
