Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA5DA6CBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfICPSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 11:18:45 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34145 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbfICPSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:18:44 -0400
Received: by mail-qt1-f180.google.com with SMTP id a13so20405495qtj.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=41G2aVZ2UIyZbN+qqTnEEAlUQce0psMlCxkdXRi0woc=;
        b=gGAhjK8E3JYUeHFI+hfwuyPjgS754Z/R0J/ID1JCj50+hthV15w4vhsy7SXXBUNkCf
         eGqZI3wy4vUOxlFjmxqqMroyQq/VghmOQASc0xovzbPzL8uBZZA4dDesrgsFmI4g25er
         frH1b85rDzemofj4z+F8adqllRrbHnZERhDAmMx2tyOqj36b+5U3IsJaobQSo6dVDsZC
         40nSEISIvq/KCWBmk8ZO/IdffaQqByrI2ZemeLR9qRFXJyZiZYMiwnbOnPlsXAacBr6n
         WwAX8wEGbiDKFCY0n9oI1D+txFfX+HU/4sApuv0c8GB5f8U7UXesIBUGK96Qbp9TgGsr
         M1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=41G2aVZ2UIyZbN+qqTnEEAlUQce0psMlCxkdXRi0woc=;
        b=YHRD/SJ6UTI+5T0UQSNN9xzP2H9ernF8AjtBWIM30aR0JO760Hxod99AKN+Nu/xqg0
         lMLhDQjl91+/9xSpVg5TDg/BdQy1DLQOHGskiSTBTIbBqsGMLLUmwtr9f2sBm97x4zfV
         KwdgLqfMjNhM/7/IVgDbsAvVxhwDxZX4lyOKwj//uXjT1jC5sIW6dzgG7s8iIHusPBZt
         Z6vayHP7jVKK+tvuBLmDU+/V7eiQPesmwRLyk1NkppaFBnns5VkZ5zkU3WAR/K6HqUsr
         ldELGCGfwEHBen6BwZNm8meoBeOhvsk7ryLOMLDNVdSRCgR5oleAZyuO6FTCdCUTVikh
         D9sA==
X-Gm-Message-State: APjAAAUovvtjc7wDLKmLQ3SB3JdVPQ0PpP7E1YhI4IfgkUyQsr45QGmM
        VGKNbWyV6DLxmjE31k2CpHMSxw==
X-Google-Smtp-Source: APXvYqx+zxtcnskjuSmXfYN7TaHQhfcYZA+gg2du0ohxxNXHWZJliwkamJBZLwCZf0UiLCwKsdnE7A==
X-Received: by 2002:ac8:2392:: with SMTP id q18mr9332116qtq.261.1567523923826;
        Tue, 03 Sep 2019 08:18:43 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f83sm802705qke.80.2019.09.03.08.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 08:18:43 -0700 (PDT)
Message-ID: <1567523922.5576.57.camel@lca.pw>
Subject: "beyond 2038" warnings from loopback mount is noisy
From:   Qian Cai <cai@lca.pw>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 03 Sep 2019 11:18:42 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

https://lore.kernel.org/linux-fsdevel/20190818165817.32634-5-deepa.kernel@gmail.
com/

Running only a subset of the LTP testsuite on today's linux-next with the above
commit is now generating ~800 warnings on this machine which seems a bit crazy.

[ 2130.970782] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#40961: comm statx04: inode does not support timestamps beyond 2038
[ 2130.970808] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#40961: comm statx04: inode does not support timestamps beyond 2038
[ 2130.970838] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#40961: comm statx04: inode does not support timestamps beyond 2038
[ 2130.971440] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#40961: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847613] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847647] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847681] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847717] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847774] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847817] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847909] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.847970] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.848004] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2131.848415] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#32769: comm statx04: inode does not support timestamps beyond 2038
[ 2134.753752] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753783] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753814] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753847] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753889] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.753929] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.754021] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.754064] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
#12: comm statx05: inode does not support timestamps beyond 2038
[ 2134.754105] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
#12: comm statx05: inode does not support timestamps beyond 2038
