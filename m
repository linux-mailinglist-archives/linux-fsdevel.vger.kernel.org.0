Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936F77696A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjGaMp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjGaMpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:45:17 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FBD10E9;
        Mon, 31 Jul 2023 05:45:11 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-486c9cd3b5eso147295e0c.0;
        Mon, 31 Jul 2023 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690807510; x=1691412310;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXu315LpVUgW3NeK4ZN7zaVbOqwRNsL28izE46Z+rhc=;
        b=DKcQ0QvrT7m4mgRhhxYB+ieT/YV8umqLn+Mv6NnfbqGq8ZzfEvvfYNE3Ef6k/e3yq7
         a3sNInkZBmP9yY8R08v4ay8AIwHrWnLkjRrswlNZgAxIm3Qu1ln2L3X845YzZu8H2Xl7
         EOLWJ10Ibyfx/Y7mTWtMIK3yNoQLXWa6UxTvuptt/iqQDDVa86v4NoOGfYx8bvH0XS2V
         nzPlBeIwdcCn4LzCFSORUiLXapW5f39JrPyHC9JwM9CaaK4wGhBiWa/bDytQOFmWMbYO
         k9WZJ6A1jVg/4ccVWcJh3r8mnGe4fjt3DX2qekvBA4+h7fjLHo49nkosXtqhvhFK38Vr
         yZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807510; x=1691412310;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tXu315LpVUgW3NeK4ZN7zaVbOqwRNsL28izE46Z+rhc=;
        b=KU5bnheMKqjtdbOMxh4w/HXkZamrjKFvAol3pOEcOPB2m3sVR1vpPEZ7oO674J+nbX
         /VPMOkoQrzdL6lCu6vQo2tmzpnFxTw2cAbYG7FZQQ5r9dw7qTMrgcHVEenrDDUFSQ+hD
         uJM2rK09AxCT0iEo2iVobs9aEUhIjdLBlfdYWK9f+29UODSLEuW9WuQ7cYBPPEfUI9Rl
         kDr3+J9HWslirtzolTmWqaMrJjRmmrnLbTEXlJ2EVoS99OvY5hKK8pxAGDDA4UtbBVI6
         UVgCZ7kMejPzFgpKB75beRrpTlaVkTYK6bwWXSlYZ+51IY5i8VVOmdebL7qGNIyj3d5/
         ixjw==
X-Gm-Message-State: ABy/qLZ86ylE3zyQysrHNHfZKlIWDIkU1JZ2lpU3iSPog46DLBPctuoA
        UGEhXuyCTx0bMi5cTcbHDVc=
X-Google-Smtp-Source: APBJJlFlxGLbEz8QK3kYhUSaUnesXmUR9TnqH+ZwVnxN6PnbiE2nC117pe2rd7X2Sxn3ohNB51t2+Q==
X-Received: by 2002:a1f:bd55:0:b0:481:388e:b903 with SMTP id n82-20020a1fbd55000000b00481388eb903mr3678417vkf.10.1690807510190;
        Mon, 31 Jul 2023 05:45:10 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id u11-20020a0cdd0b000000b0063600a119fcsm3732051qvk.37.2023.07.31.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:45:09 -0700 (PDT)
Date:   Mon, 31 Jul 2023 08:45:09 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Message-ID: <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch>
In-Reply-To: <831028.1690791233@warthog.procyon.org.uk>
References: <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch>
 <20230718160737.52c68c73@kernel.org>
 <000000000000881d0606004541d1@google.com>
 <0000000000001416bb06004ebf53@google.com>
 <792238.1690667367@warthog.procyon.org.uk>
 <831028.1690791233@warthog.procyon.org.uk>
Subject: Re: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?]
 INFO: task hung in pipe_release (4)
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
> Hi Willem,
> 
> Here's a reduced testcase.  I doesn't require anything special; the key is
> that the amount of data placed in the packet by the send() - it's related to
> the MTU size.  It needs to stuff in sufficient data to go over the
> fragmentation limit (I think).
> 
> In this case, my interface's MTU is 8192.  send() is sticking in 8161 bytes of
> data and then the output from the aforeposted debugging patch is:
> 
> 	==>splice_to_socket() 6630
> 	udp_sendmsg(8,8)
> 	__ip_append_data(copy=-1,len=8, mtu=8192 skblen=8189 maxfl=8188)
> 	pagedlen 9 = 9 - 0
> 	copy -1 = 9 - 0 - 1 - 9
> 	length 8 -= -1 + 0
> 	__ip_append_data(copy=8172,len=9, mtu=8192 skblen=20 maxfl=8188)
> 	copy=8172 len=9
> 	skb_splice_from_iter(8,9)
> 	__ip_append_data(copy=8164,len=1, mtu=8192 skblen=28 maxfl=8188)
> 	copy=8164 len=1
> 	skb_splice_from_iter(0,1)
> 	__ip_append_data(copy=8164,len=1, mtu=8192 skblen=28 maxfl=8188)
> 	copy=8164 len=1
> 	skb_splice_from_iter(0,1)
> 	__ip_append_data(copy=8164,len=1, mtu=8192 skblen=28 maxfl=8188)
> 	copy=8164 len=1
> 	skb_splice_from_iter(0,1)
> 	__ip_append_data(copy=8164,len=1, mtu=8192 skblen=28 maxfl=8188)
> 	copy=8164 len=1
> 	skb_splice_from_iter(0,1)
> 	copy=8164 len=1
> 	skb_splice_from_iter(0,1)
> 
> It looks like send() pushes 1 byte over the fragmentation limit, then the
> splice sees -1 crop up, the length to be copied is increased by 1, but
> insufficient data is available and we go into an endless loop.
> 
> ---
> #define _GNU_SOURCE
> #include <arpa/inet.h>
> #include <fcntl.h>
> #include <netinet/in.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <sys/mman.h>
> #include <sys/uio.h>
> 
> #define OSERROR(R, S) do { if ((long)(R) == -1L) { perror((S)); exit(1); } } while(0)
> 
> int main()
> {
> 	struct sockaddr_storage ss;
> 	struct sockaddr_in sin;
> 	void *buffer;
> 	unsigned int tmp;
> 	int pfd[2], sfd;
> 	int res;
> 
> 	OSERROR(pipe(pfd), "pipe");
> 
> 	sfd = socket(AF_INET, SOCK_DGRAM, 0);
> 	OSERROR(sfd, "socket/2");
> 
> 	memset(&sin, 0, sizeof(sin));
> 	sin.sin_family = AF_INET;
> 	sin.sin_port = htons(0);
> 	sin.sin_addr.s_addr = htonl(0xc0a80601);
> #warning you might want to set the address here - this is 192.168.6.1
> 	OSERROR(connect(sfd, (struct sockaddr *)&sin, sizeof(sin)), "connect");
> 
> 	buffer = mmap(NULL, 1024*1024, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
> 	OSERROR(buffer, "mmap");
> 
> 	OSERROR(send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE), "send");
> #warning you need to adjust the length on the above line to match your MTU
> 
> 	OSERROR(write(pfd[1], buffer, 8), "write");
> 
> 	OSERROR(splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0), "splice");
> 	return 0;
> }

That's helpful.

Is the MSG_CONFIRM needed to trigger this?

Appending to a MSG_MORE datagram that previously fit within MTU, but
no longer, triggers the copy from skb_prev to skb in if (fraggap).

I did not see how that would cause issues, but maybe something in how
that second skb is setup makes none of the cases in the while loop
successfully append, yet also not fail and exit. It would be helpful
to know which path it takes (I assume skb_splice_from_iter) and what
that returns (0?).

Is this indeed trivially sidestepped if downgrading from splicing to
regular copying with fragmentation?

@@ -1042,7 +1042,7 @@ static int __ip_append_data(struct sock *sk,
                if (inet->hdrincl)
                        return -EPERM;
                if (rt->dst.dev->features & NETIF_F_SG &&
-                   getfrag == ip_generic_getfrag)
+                   getfrag == ip_generic_getfrag && transhdrlen)

 


