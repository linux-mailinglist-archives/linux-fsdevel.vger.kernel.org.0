Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002742098B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 05:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbgFYDBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 23:01:13 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:35028 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389585AbgFYDBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 23:01:13 -0400
Received: by mail-il1-f198.google.com with SMTP id m14so3047586iln.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 20:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wKHziB1HTjinXOROzU9x8QSF9UVTTl5CGULxlu3fS2A=;
        b=bG8TpHhwDHZMM3kp+HHw8YbsywdbdsJJoYku8lGObDewgvXmFllSigxKvIHd6Z+nJ+
         twsKtr3Itjvnv8tzpdD44atcIFK3rdKwQIZDvK/XCXSKqm+RmuuoKhRSc0Sth56jlY0Z
         JQJ+yPSa85K5W4LAmTqt3BPiXnC/8KwlWqUzz12bYX9iXt/Q+MKOAYCjT93/BXHPZAda
         gvmnpGvtvsNc0fyHmpH2j2tKgUZsso3lcTLDdRpg2MH2zSuCSPajkS4faWGvccHO0wv/
         +G/963g1IJn7N9q+cHoqLwwvPNY4Q2dNK64c5sqolAFsClw3N521ModZHflc27Nhd1tq
         Cqpw==
X-Gm-Message-State: AOAM533G18BjV+JaPOJNtg8vNNAFvWeDVqGpif2RwA/HXOv0T9DUJpsV
        oT0cS0PpkfoYHrp2FYAo0sNPAZPrJVyrAfZ9pATRughPwx4Z
X-Google-Smtp-Source: ABdhPJxbs1SAyL/M/fgk3l40cIJl7wJzsJfAm+GKPt/0zA1RuUK6bKXZkytrERisRhBiK2xMcbSQIrQom47jw0jbMN8Qdv/m0rQo
MIME-Version: 1.0
X-Received: by 2002:a92:290b:: with SMTP id l11mr31731641ilg.145.1593054071282;
 Wed, 24 Jun 2020 20:01:11 -0700 (PDT)
Date:   Wed, 24 Jun 2020 20:01:11 -0700
In-Reply-To: <00000000000047770d05a1c70ecb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006e0ff05a8dfce2d@google.com>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
From:   syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>
To:     a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org,
        bvanassche@acm.org, davem@davemloft.net, dongli.zhang@oracle.com,
        hdanton@sina.com, jianchao.w.wang@oracle.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This bug is marked as fixed by commit:
blk-mq: Fix a recently introduced regression in
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
