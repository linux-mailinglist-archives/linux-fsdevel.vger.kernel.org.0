Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF63F76BF11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjHAVSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjHAVSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:18:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA651FF;
        Tue,  1 Aug 2023 14:18:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4039f7e1d3aso46544271cf.0;
        Tue, 01 Aug 2023 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690924686; x=1691529486;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENvvMC35pukF5ojzHyo5Z5dKspFSqXLPb4hIWaoW6Vs=;
        b=QGxwPFTLr0Ijpw8NqwPoLwfTzsV1c/Sbv/icXJRj2I29nkPl4EEqdvtKXCT5JrQ3Tf
         G4PEAh+sTunfJRQKlEtLHUdRZ2rvRo5MLKx8AM0lKHvxROlhiIu5cDcp9XNeu9PLgV00
         VrprxXBcMILUoW52lfanhnu3EeQc9WOGOpBxedrNKqCuBYaZlThWTV1rPXWz58eD3MY8
         8yutgXVMFc+vVgqhxXYmRrzar2zjHxiNVyXlqhGLE0Ev5CWHWb6smI0HMtONn7CJrIHP
         8iyPj5S59sq6/4u4DRjCfGKlMwH6EBGdJpTKPO5CvrMTnd4q/2+sMft+ktoxAHNvt7/y
         CdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690924686; x=1691529486;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ENvvMC35pukF5ojzHyo5Z5dKspFSqXLPb4hIWaoW6Vs=;
        b=jjErB7jh78sM6AZlVBZZkYLse/SjCthTHNkVIz3CDyPbL6tM5FqRfhxdUD97EmoiOZ
         jvipcwiEAP2ImW1zOIu3sn4M1Y6iVxrGrG0pU4xQsXgf1xKplw+LBQSBkIIT+bvcUX86
         jjNN4ObXK/bcags5OLhJWuuOCu35opuNE0GGdM0JzHg8nXyQLyO+uspj75JiTjl1+UC0
         cXxkOxIIz/Rl5KtlFoTqxfznNdKLGDC/cwVhc2Hsx4ZedPo5QobXJNxpWvmARcsscxny
         iwvMhBrnQ0sePDKBYMax7vH4apTcsecyL1AxAfw8w8SbKRFhc7uFtGnfC3fREVIqmOwV
         XSqA==
X-Gm-Message-State: ABy/qLbCCkaads/efIPSZmiS5Bkh1ZTTHpKp9kTVUzUNLwNx/OvuYEbO
        IlqpMpqlUwaiSxWH8493gzg=
X-Google-Smtp-Source: APBJJlEiyHcWyMP4Hr2e0zP22CuZJxyfOPV+G08QykQJpQeWRhVUDa+h8wGLidSMX6FgiNJMd/H17g==
X-Received: by 2002:ac8:7d4b:0:b0:403:b6d2:8dc4 with SMTP id h11-20020ac87d4b000000b00403b6d28dc4mr17520144qtb.34.1690924685871;
        Tue, 01 Aug 2023 14:18:05 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id q27-20020ac8411b000000b003f9efa2ddb4sm3363636qtl.66.2023.08.01.14.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 14:18:00 -0700 (PDT)
Date:   Tue, 01 Aug 2023 17:17:56 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com,
        syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Message-ID: <64c97684ee5e3_1d7aa3294da@willemb.c.googlers.com.notmuch>
In-Reply-To: <1569149.1690924207@warthog.procyon.org.uk>
References: <1569149.1690924207@warthog.procyon.org.uk>
Subject: RE: [PATCH net v2] udp: Fix __ip{,6}_append_data()'s handling of
 MSG_SPLICE_PAGES
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote:
> __ip_append_data() can get into an infinite loop when asked to splice into
> a partially-built UDP message that has more than the frag-limit data and up
> to the MTU limit.  Something like:
> 
>         pipe(pfd);
>         sfd = socket(AF_INET, SOCK_DGRAM, 0);
>         connect(sfd, ...);
>         send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE);
>         write(pfd[1], buffer, 8);
>         splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);
> 
> where the amount of data given to send() is dependent on the MTU size (in
> this instance an interface with an MTU of 8192).
> 
> The problem is that the calculation of the amount to copy in
> __ip_append_data() goes negative in two places, and, in the second place,
> this gets subtracted from the length remaining, thereby increasing it.
> 
> This happens when pagedlen > 0 (which happens for MSG_ZEROCOPY and
> MSG_SPLICE_PAGES), the terms in:
> 
>         copy = datalen - transhdrlen - fraggap - pagedlen;
> 
> then mostly cancel when pagedlen is substituted for, leaving just -fraggap.
> This causes:
> 
>         length -= copy + transhdrlen;
> 
> to increase the length to more than the amount of data in msg->msg_iter,
> which causes skb_splice_from_iter() to be unable to fill the request and it
> returns less than 'copied' - which means that length never gets to 0 and we
> never exit the loop.
> 
> Fix this by:
> 
>  (1) Insert a note about the dodgy calculation of 'copy'.
> 
>  (2) If MSG_SPLICE_PAGES, clear copy if it is negative from the above
>      equation, so that 'offset' isn't regressed and 'length' isn't
>      increased, which will mean that length and thus copy should match the
>      amount left in the iterator.
> 
>  (3) When handling MSG_SPLICE_PAGES, give a warning and return -EIO if
>      we're asked to splice more than is in the iterator.  It might be
>      better to not give the warning or even just give a 'short' write.
> 
> The same problem occurs in __ip6_append_data(), except that there's a check
> in there that errors out with EINVAL if copy < 0.  Fix this function in
> much the same way as the ipv4 variant but also skip the erroring out if
> copy < 0.

I don't think the two should be combined.

Removing that branch actually opens up to new bugs, e.g., in MSG_ZEROCOPY.

Since the ipv6 stack is not subject to this bug in MSG_SPLICE_PAGES,
I think v1 on its own is correct, and has the right Fixes tag.

If we think this IPv6 branch is mistaken and a bug, then that would
have a different Fixes tag, going back to ancient history. But arguably
safer to limit that net-next, if touching that at all.

It makes sense to update MSG_SPLICE_PAGES in the IPv6 path to be
equivalent to the IPv4 path, and to be correct if that branch is
ever removed.
