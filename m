Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D1F4D3C09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiCIV00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 16:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiCIV0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:26:25 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D6C1D;
        Wed,  9 Mar 2022 13:25:26 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h11so5086352ljb.2;
        Wed, 09 Mar 2022 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faagWhjpx/C+78rbTRUlqrujdKXH1nBvBCpOWDeeLcE=;
        b=mk2q+mzk5HsfwVarKKtDF/O509Kw7nk76bSAz67DQzCZBZ4YG7tlbo4rkLXEVH+ywq
         zbOKYMKlbYQL7WCVlI7foMVU90yNbrtBHnPr/c0t4mY3ndu5wf7O2Pe2I5gEM4i2REbR
         w4YMsPrISQyLreTeZBKI4vX5ZRhF5vAXm7Wl8nYnT46Lo2S/D9EU2Dska2OeMM4WL6LC
         HNjEVSARehHSm+DYWZWZosRn//lkeK+NSkFulDhTMC98zk4heuMx8cvjfVZtdt36FsrQ
         vjnia6bxAnMA8dT3nPTy/L36cqKeFtAJxAMJnlqdFhlLyXKM5KVR+nD7TTp37ZYOjXMx
         oreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faagWhjpx/C+78rbTRUlqrujdKXH1nBvBCpOWDeeLcE=;
        b=aY2VH7LyQMKRosn1jLjWgvF9F2hHa6aAPW1q4T3hnCC5fig3RZn6+4UV+xBqlbB7aG
         1fZmszVhVbD1Lo4r1yHdqFM/H66CLRiYEBcrbHKKISNiS6Zyem6wtkJYPTMR5/msB581
         e5WH9w4VLCSbJ1U/iGItMigUsk9BVsop+prx6XNn20YW6M4ZCXF7/DyYuJh+cqONDVY+
         x/H/NK5RT3KKgEWaMblt3HWHOOC0bMI45J4i0PeqRjvoFBrD4Mwwx8bJ4Non/zEf0oll
         J4KVKFWw4Jn05lxdc4tqmLIpnw0Kj9fS4AwosZfK45VhgS+ykuPQ4R9WqMrwy2G9so1M
         qKow==
X-Gm-Message-State: AOAM530LD7oDgt2taV5rhM36APWC42mT9cTzXv3+9G9NgWqQX0WXaunv
        nSM4l6+R7P+F2jswPGWvcw20i4dRZq63pByKmvQAsfurOsI=
X-Google-Smtp-Source: ABdhPJzAnGwPCS++Kc3gR676jD1UgtYFujMXHfqzn0Fbtf4T61RBiC7WoNilT+Gq9Uyxcpr48v2MeyGwq1zn3Aww70k=
X-Received: by 2002:a05:651c:1597:b0:247:f79c:5794 with SMTP id
 h23-20020a05651c159700b00247f79c5794mr963510ljq.398.1646861124097; Wed, 09
 Mar 2022 13:25:24 -0800 (PST)
MIME-Version: 1.0
References: <2571706.1643663173@warthog.procyon.org.uk> <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
 <CAH2r5muY-bh6H5SSmAF37TAHiZCSa8-UbMKk2=HQEmxyK1vdsQ@mail.gmail.com> <C9AC7BE7-E72A-47FC-AF70-0134AE9AAE66@oracle.com>
In-Reply-To: <C9AC7BE7-E72A-47FC-AF70-0134AE9AAE66@oracle.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 9 Mar 2022 15:25:12 -0600
Message-ID: <CAH2r5msvGnRJCM8oe9b9R-P2DY264YrodXw1=C6h0BhpsNYrgA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     David Howells <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Samuel Cabrero <scabrero@suse.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Hyeoncheol Lee <hyc.lee@gmail.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:17 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> > On Mar 4, 2022, at 3:06 PM, Steve French <smfrench@gmail.com> wrote:
> >
> > On Tue, Feb 1, 2022 at 10:51 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>> On Jan 31, 2022, at 4:06 PM, David Howells <dhowells@redhat.com> wrote:
> >>>
> >>> I've been working on a library (in fs/netfs/) to provide network filesystem
> >>> support services, with help particularly from Jeff Layton.  The idea is to
> >>> move the common features of the VM interface, including request splitting,
> >>> operation retrying, local caching, content encryption, bounce buffering and
> >>> compression into one place so that various filesystems can share it.
> >>
> >> IIUC this suite of functions is beneficial mainly to clients,
> >> is that correct? I'd like to be clear about that, this is not
> >> an objection to the topic.
> >>
> >> I'm interested in discussing how folios might work for the
> >> NFS _server_, perhaps as a separate or adjunct conversation.
> >
> > That is an interesting point.   Would like to also discuss whether it
> > could help ksmbd,
>
> Agreed that ksmbd might also benefit.
>
> Of primary interest is how read and write operations move
> their payloads from the network transports directly to the
> page cache. For the most efficient operation, the transport
> layer would need to set up a receive buffer using page
> cache pages instead of what is currently done: receive
> buffers are constructed from anonymous pages and then these
> pages replace the file's page cache pages.
>
> RDMA transports make this straightforward, at least from
> the transport layer's perspective.
>
>
> > and would like to continue discussion of netfs improvements - especially am
> > interested in how we can improve throttling when network (or server)
> > is congested
> > (or as network adapters are added/removed and additional bandwidth is
> > available).
>
> As I understand it, the protocols themselves have flow control
> built in. At least SMB Direct and NFS/RDMA do, and NFSv4
> sessions provides a similar mechanism for transports that don't
> have a native flow control mechanism. I'm not sufficiently
> familiar with SMB to know how flow control works there.
>
> However, each of these mechanisms all have their own specific
> rules. I'm not sure if there's much that can be extracted into
> a common library, but can you be more specific about what is
> needed?

At a high level given network latencies, we want to make sure
a few requests are in process on each interface unless server
is throttling back (or client observers problems) so the
network or cluster fs probably needs to be able to set:
- optimal i/o size (larger is usually better, for most SMB3.1.1
cases it would typically be 1M or 4M, but server negotiates
this with client at mount time)
- typical number of I/Os in flight (e.g. for SMB3.1.1 this
might be 2 or 3 times the number of channels)

and then dynamically we need to be able to reduce
(and then increase back to the default) the number of i/o when two things
happen:
- low on credits (the server returns 'credits' available
on each response, so when server is busy this number
can go down to the point where we don't want to do
much readahead)
- network or server events that indicate temporarily stopping
readahead (e.g. reconnect, or errors indicating server
resource problems)
- server notification about resource movement (server or share move)
- server notification about adding or deleting a network interface
(this and the above are handled via a loosely related
protocol called the 'Witness protocol' which generates dynamic
server notification to the client about important events).
Samuel Cabrero might have additional ideas about new events
we could add that could help here.

There also may be low memory situations where we see a need to
reduce the amount of resources used by the client fs.
-- 
Thanks,

Steve
