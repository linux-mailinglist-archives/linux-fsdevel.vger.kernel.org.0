Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10BC740197
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjF0Qtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjF0Qtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:49:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437B97;
        Tue, 27 Jun 2023 09:49:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso302399566b.1;
        Tue, 27 Jun 2023 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687884568; x=1690476568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIF14ZRhhNhvP7s/dCFS3UgnLk5r7liSptBE93jJiP0=;
        b=cGOUc/1TLhs56qcwE8WN7OTKbFjZfn6zPmdhM3EoLJkyaH3Ec0Ix8CnjESLMLXoDmB
         F3S1It9z7AcZIsJ3zMuUkojpZWjtzvtVGAeGuaXk8j/t5Lq4et9sj8oYUrFLrjKO0TMe
         nT/HhBjuV2PgMvPFVrddicOE7kbubj9lkP6otJoSuKnexHCDSrb1ubjQadXLjN87kgl7
         scPhMGhS+sIswFPlRDUzftwTwETjkql2qJLI1HTgAjVTQm2hyWxAgL1+/eo/O26NTpn0
         Urt2Nnuiz6p1jTLsxQB8sAII7VPEqyj6Zxxz5xC8jnUY/6Rv49Q8ninI8WcJGE4o+AFk
         Xaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884568; x=1690476568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIF14ZRhhNhvP7s/dCFS3UgnLk5r7liSptBE93jJiP0=;
        b=TRRxpbEbZTJWcp4z1U2kTt70lSZGpc/H2tV+sIG5F50Wh67PVJUiirYrAmzV6lGOE6
         7ibnDoJDXn3RCj/mTE9wlIcSJ2J45Kg+M9p43z+rheU77PctLm+o4h/ThErH93tg5X0S
         kXxGZCzkP2U14EGh8lodo6t9+Pv/Rsc8ZRahQd9JAqINovPpbbreT/ahd1HoZN9GXDG5
         0at6XMJH9BAYFkKDffZtXMoD6/k9dRH3MyRnWz8EKS4ZUHSk6GsR7P+2NCOhoqjUgQRl
         fmElGyUGCy9qdXWiJxj3Z+CjPJfTcsz6WIPl0yVEYKsoAQKSvksuQsbaIWhKrPOjStLh
         2fdg==
X-Gm-Message-State: AC+VfDzsR+RvLTWphIj1d4Y0qf/0qpUTXOtCwgp7LsbjfHcOnFwsjnDn
        GvQKzq5MHSgcTHZtoame2mc=
X-Google-Smtp-Source: ACHHUZ7FfnMKUnb75ZuZJnHVFM+fgisgQVLRYsjvmlbWG4AbNckpTrSwdsrlHBKUg/BItw73XkN+ZQ==
X-Received: by 2002:a17:907:c0a:b0:96f:d345:d0f7 with SMTP id ga10-20020a1709070c0a00b0096fd345d0f7mr28695988ejc.62.1687884568091;
        Tue, 27 Jun 2023 09:49:28 -0700 (PDT)
Received: from [192.168.0.107] ([77.126.161.239])
        by smtp.gmail.com with ESMTPSA id i26-20020a1709063c5a00b00991d54db2acsm2303686ejg.44.2023.06.27.09.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 09:49:27 -0700 (PDT)
Message-ID: <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
Date:   Tue, 27 Jun 2023 19:49:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Gal Pressman <gal@nvidia.com>, ranro@nvidia.com,
        samiram@nvidia.com, drort@nvidia.com,
        Tariq Toukan <tariqt@nvidia.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
 <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
 <20230522121125.2595254-1-dhowells@redhat.com>
 <20230522121125.2595254-9-dhowells@redhat.com>
 <2267272.1686150217@warthog.procyon.org.uk>
 <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
 <776549.1687167344@warthog.procyon.org.uk>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <776549.1687167344@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 19/06/2023 12:35, David Howells wrote:
> Tariq Toukan <ttoukan.linux@gmail.com> wrote:
> 
>> Any other debug information that we can provide to progress with the analysis?
> 
> Can you see if the problem still happens on this branch of my tree?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=sendpage-3-frag
> 
> It eases the restriction that the WARN_ON is warning about by (in patch 1[*])
> copying slab objects into page fragments.
> 
> David
> 
> [*] "net: Copy slab data for sendmsg(MSG_SPLICE_PAGES)"
> 

Hi David,

Unfortunately, it still happens:

------------[ cut here ]------------
WARNING: CPU: 2 PID: 93427 at net/core/skbuff.c:7013 
skb_splice_from_iter+0x299/0x550
Modules linked in: bonding nf_tables vfio_pci ip_gre geneve ib_umad 
rdma_ucm ipip tunnel4 ip6_gre gre ip6_tunnel tunnel6 ib_ipoib 
mlx5_vfio_pci vfio_pci_core mlx5_ib ib_uverbs mlx5_core sch_mqprio 
sch_mqprio_lib sch_netem iptable_raw vfio_iommu_type1 vfio openvswitch 
nsh rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm 
ib_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink 
xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss 
oid_registry overlay zram zsmalloc fuse [last unloaded: nf_tables]
CPU: 2 PID: 93427 Comm: nginx_openssl_3 Tainted: G        W 
6.4.0-rc6_net_next_mlx5_9b6e6b6 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:skb_splice_from_iter+0x299/0x550
Code: 49 8b 57 08 f6 c2 01 0f 85 89 01 00 00 8b 0d 22 b3 4a 01 4c 89 fa 
85 c9 0f 8f 81 01 00 00 48 8b 12 80 e6 02 0f 84 a3 00 00 00 <0f> 0b 48 
c7 c1 fb ff ff ff 44 01 6b 70 44 01 6b 74 44 01 ab d0 00
RSP: 0018:ffff8882a16d3a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88821a89ee00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffea0004c2cfc0 RDI: ffff88821a89ee00
RBP: 0000000000000f34 R08: 0000000000000011 R09: 0000000000000f34
R10: 0000000000000000 R11: 000000000000000d R12: 0000000000000004
R13: 0000000000002d0f R14: 0000000000000f34 R15: ffffea0004c2d000
FS:  00007f5c383eb740(0000) GS:ffff88885f880000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002ea5000 CR3: 0000000264ffe006 CR4: 0000000000370ea0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <TASK>
  ? __warn+0x79/0x120
  ? skb_splice_from_iter+0x299/0x550
  ? report_bug+0x17c/0x190
  ? handle_bug+0x3c/0x60
  ? exc_invalid_op+0x14/0x70
  ? asm_exc_invalid_op+0x16/0x20
  ? skb_splice_from_iter+0x299/0x550
  tcp_sendmsg_locked+0x375/0xd00
  tls_push_sg+0xdd/0x230
  tls_push_data+0x6de/0xb00
  tls_device_sendmsg+0x7a/0xd0
  sock_sendmsg+0x38/0x60
  sock_write_iter+0x97/0x100
  vfs_write+0x2df/0x380
  ksys_write+0xa7/0xe0
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f5c381018b7
Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e 
fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffee9750848 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000004000 RCX: 00007f5c381018b7
RDX: 0000000000004000 RSI: 0000000002ea2dc0 RDI: 00000000000000d1
RBP: 0000000001d1bbe0 R08: 00007ffee974ffe0 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000002ea2dc0
R13: 0000000001d2a7e0 R14: 0000000000004000 R15: 0000000000004000
  </TASK>
---[ end trace 0000000000000000 ]---
