Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0A50A32E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389647AbiDUOug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389650AbiDUOuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F54342A32
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650552462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLrWjtc7m2YPAUBTVVwtoIkXOvWSSpY/9+OaSUBZTKs=;
        b=Wz89bDwXC3E6QTZRHJ/nnUod9kZgQmL5Cqbc+xqX7+Xq/m/TQwRJYVXE9LVpylABFs4T38
        /SM0dV435xGPRXmR6eiNfpMx7Yvq7Ybgn7V5w+btrgL+XienuxpcRhc80ZTHEdjCvjOQ/c
        p5AG8GBWyo8bhFwkhJwiplBJxS7joUI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-1Nzm7Wr3PpiJJfxG5ZxQMg-1; Thu, 21 Apr 2022 10:47:36 -0400
X-MC-Unique: 1Nzm7Wr3PpiJJfxG5ZxQMg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1356B1857F08;
        Thu, 21 Apr 2022 14:47:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3636554E88D;
        Thu, 21 Apr 2022 14:47:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-9-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-9-jefflexu@linux.alibaba.com> <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: Re: [PATCH v9 08/21] cachefiles: document on-demand read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1447052.1650552451.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 21 Apr 2022 15:47:31 +0100
Message-ID: <1447053.1650552451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +When working in its original mode, cachefiles mainly

I'd delete "mainly" there.

> serves as a local cache
> +for a remote networking fs - while in on-demand read mode, cachefiles c=
an boost
> +the scenario where on-demand read semantics is

is -> are.

> +The essential difference between these two modes is that, in original m=
ode,
> +when a cache miss occurs, the netfs will fetch the data from the remote=
 server
> +and then write it to the cache file.  With on-demand read mode, however=
,
> +fetching the data and writing it into the cache is delegated to a user =
daemon.

The starting sentence seems off.  How about:

  The essential difference between these two modes is seen when a cache mi=
ss
  occurs: In the original mode, the netfs will fetch the data from the rem=
ote
  server and then write it to the cache file; in on-demand read mode, fetc=
hing
  data and writing it into the cache is delegated to a user daemon.

> +Protocol Communication
> +----------------------
> +
> +The on-demand read mode relies on

relies on -> uses

> a simple protocol used

Delete "used".

> for communication
> +between kernel and user daemon. The protocol can be modeled as::
> +
> +	kernel --[request]--> user daemon --[reply]--> kernel
> +
> +The cachefiles kernel module will send requests to the user daemon when=
 needed.
> +The user daemon needs to

needs to -> should

> poll on

poll on -> poll

> the devnode ('/dev/cachefiles') to check if
> +there's a pending request to be processed.  A POLLIN event will be retu=
rned
> +when there's a pending request.
> +
> +The user daemon then reads the devnode to fetch a request and process i=
t
> +accordingly.

Reading the devnode doesn't process the request, so I think something like=
:

"... and process it accordingly" -> "... that it can then process."

or:

"... and process it accordingly" -> "... to process."

> It is worth noting

"It should be noted"

> that each read only gets one request. When

... it has ...

> +finished processing the request, the user daemon needs to

needs to -> should write

> write the reply to
> +the devnode.
> +
> +Each request starts with a message header of the form::
> +
> +	struct cachefiles_msg {
> +		__u32 msg_id;
> +		__u32 opcode;
> +		__u32 len;
> +		__u32 object_id;
> +		__u8  data[];
> +	};
> +
> +	where:
> +
> +	* ``msg_id`` is a unique ID identifying this request among all pending
> +	  requests.
> +
> +	* ``opcode`` indicates the type of this request.
> +
> +	* ``object_id`` is a unique ID identifying the cache file operated on.
> +
> +	* ``data`` indicates the payload of this request.
> +
> +	* ``len`` indicates the whole length of this request, including the
> +	  header and following type-specific payload.
> +
> +
> +Turn on On-demand Mode

Turning on

> +----------------------
> +
> +An optional parameter is added

is added -> becomes available

> to the "bind" command::
> +
> +	bind [ondemand]
> +
> +When the "bind" command takes without

takes without -> is given no

> argument, it defaults to the original
> +mode.  When the "bind" command is given

When it is given

> the "ondemand" argument, i.e.
> +"bind ondemand", on-demand read mode will be enabled.
> +
> +
> +The OPEN Request
> +----------------
> +
> +When the netfs opens a cache file for the first time, a request with th=
e
> +CACHEFILES_OP_OPEN opcode, a.k.a an OPEN request will be sent to the us=
er
> +daemon.  The payload format is of the form::
> +
> +	struct cachefiles_open {
> +		__u32 volume_key_size;
> +		__u32 cookie_key_size;
> +		__u32 fd;
> +		__u32 flags;
> +		__u8  data[];
> +	};
> +
> +	where:
> +
> +	* ``data`` contains the volume_key followed directly by the cookie_key=
.
> +	  The volume key is a NUL-terminated string; the cookie key is binary
> +	  data.
> +
> +	* ``volume_key_size`` indicates the size of the volume key in bytes.
> +
> +	* ``cookie_key_size`` indicates the size of the cookie key in bytes.
> +
> +	* ``fd`` indicates an anonymous fd referring to the cache file, throug=
h
> +	  which the user daemon can perform write/llseek file operations on th=
e
> +	  cache file.
> +
> +
> +The user daemon is able to distinguish the requested cache file with th=
e given
> +(volume_key, cookie_key) pair.

"The user daemon can use the given (volume_key, cookie_key) pair to
distinguish the requested cache file." might sound better.

> Each cache file has a unique object_id, while it
> +may have multiple anonymous fds. The user daemon may duplicate anonymou=
s fds
> +from the initial anonymous fd indicated by the @fd field through dup().=
 Thus
> +each object_id can be mapped to multiple anonymous fds, while the usr d=
aemon
> +itself needs to maintain the mapping.
> +
> +With the given anonymous fd, the user daemon can fetch data and write i=
t to the
> +cache file in the background, even when kernel has not triggered a cach=
e miss
> +yet.
> +
> +The user daemon should complete the READ request

READ request -> OPEN request?

> by issuing a "copen" (complete
> +open) command on the devnode::
> +
> +	copen <msg_id>,<cache_size>
> +
> +	* ``msg_id`` must match the msg_id field of the previous OPEN request.
> +
> +	* When >=3D 0, ``cache_size`` indicates the size of the cache file;
> +	  when < 0, ``cache_size`` indicates the

the -> any

> error code ecountered

encountered

> by the
> +	  user daemon.
> +
> +
> +The CLOSE Request
> +-----------------
> +
> +When a cookie withdrawn, a CLOSE request (opcode CACHEFILES_OP_CLOSE) w=
ill be
> +sent to the user daemon. It will notify

It will notify -> This tells

> the user daemon to close all anonymous
> +fds associated with the given object_id.  The CLOSE request has no exte=
a

extra

> +payload.
> +
> +
> +The READ Request
> +----------------
> +
> +When on-demand read mode is turned on, and a cache miss encountered,

"When a cache miss is encountered in on-demand read mode,"

> the kernel
> +will send a READ request (opcode CACHEFILES_OP_READ) to the user daemon=
. This
> +will tell

will tell -> tells/asks

> the user daemon to fetch data

data -> the contents

> of the requested file range. The payload
> +is of the form::
> +
> +	struct cachefiles_read {
> +		__u64 off;
> +		__u64 len;
> +	};
> +
> +	where:
> +
> +	* ``off`` indicates the starting offset of the requested file range.
> +
> +	* ``len`` indicates the length of the requested file range.
> +
> +
> +When receiving

receiving -> it receives

> a READ request, the user daemon needs to

needs to -> should

> fetch the

requested

> data of the
> +requested file range,

"of the requested file range," -> "" (including the comma, I think)

> and then

"then" -> ""

> write it to the cache file identified by
> +object_id.
> +
> +To finish

When it has finished

> processing the READ request, the user daemon should reply with

with -> by using

> the
> +CACHEFILES_IOC_CREAD ioctl on one of the anonymous fds associated with =
the given
> +object_id

given object_id -> object_id given

> in the READ request.  The ioctl is of the form::
> +
> +	ioctl(fd, CACHEFILES_IOC_CREAD, msg_id);
> +
> +	* ``fd`` is one of the anonymous fds associated with the given object_=
id
> +	  in the READ request.

the given object_id in the READ request -> object_id

> +
> +	* ``msg_id`` must match the msg_id field of the previous READ request.

By "previous READ request" is this referring to something different to "th=
e
READ request" you mentioned against the fd parameter?

David

