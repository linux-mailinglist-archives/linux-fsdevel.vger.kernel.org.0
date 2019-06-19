Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A94B2B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFSHLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 03:11:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38591 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfFSHLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:11:01 -0400
Received: by mail-io1-f70.google.com with SMTP id h4so19731141iol.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 00:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dA0fKhI3N29hx55QN7yMpshQ+ovUMn3cPeA5Fhie0RE=;
        b=rMN1xWNuMOd4gwDR/ayxCvpFqWY3Pb8O8knba5SQmHKcfL7+epfqj2S3IFKk2hGS+P
         Qs/SszlR1c6m9WwsAd/7jOYpCzHKLgv6AEBT94Bh22ylm0hfWKOt+ksnE25uChrTH23m
         TdIbnv4WL1xAgEXPm+rrusfnZLVMwIYSaGF2uYN0vo/pyeA7a8eie0RZLHdQJDzrKh1n
         WD3iGIU65B7f9GjzdFdVKx5XDvQrf0u3eoqFQtmw3IcR2WvuKsAl0NJDz+5OLMUe3Avb
         hi5dmxZPGa0DT4Uw/GzRscWMG8g3LZf9RpKQg0nlPKji4lmsm/TdPm/pYnZC1uZVVkh0
         HFnQ==
X-Gm-Message-State: APjAAAW23XQVS2c+9saUt0YDnqgIqxQgqrwd+HU21CdL4wEaaQMIn9S7
        M/03V1g9X+MEIKgdws4v8SiN+IrXnqx4Wl+0AOUVAbH1NnEN
X-Google-Smtp-Source: APXvYqzkZp+PQ3mAuNYicnp5VPclFiKPKMckf04v2MwIJjKZTDInYOMm5BJwnLwOHlRr8iun7rJpj/mL0PeHTluH7712LhbuVY20
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2248:: with SMTP id o8mr17747825ioo.90.1560928260665;
 Wed, 19 Jun 2019 00:11:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 00:11:00 -0700
In-Reply-To: <CAOQ4uxh9ZWghUNS3i_waNq5huitwwypEwY9xEWddFo1JHYu88g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000803cc4058ba7eef7@google.com>
Subject: Re: WARNING in fanotify_handle_event
From:   syzbot <syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mbobrowski@mbobrowski.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com

Tested on:

commit:         a6a3fd5c fanotify: update connector fsid cache on add mark
git tree:       https://github.com/amir73il/linux.git  
fsnotify-fix-fsid-cache
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
