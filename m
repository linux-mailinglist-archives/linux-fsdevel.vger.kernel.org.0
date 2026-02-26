Return-Path: <linux-fsdevel+bounces-78637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCSTMhO0oGmHlwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:58:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B571AF580
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4301430C731C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B42423A8F;
	Thu, 26 Feb 2026 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1ZfUhdt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE54330B2C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139515; cv=pass; b=DGfquDIUHPCZkDEmDHg2GGECgK7NGAqDiV/neD2ri11H9cYtgjSKhzTqha7bugjrKBce2b6kvwsdsSVthQqwVESvfF2AxpOBdDZkUaQwgNU05FhIxmvVrSksw+D6ZoLeyWql1sBhw1rYxVyb+POl+BA46gGtwWgnD7q30wLPP4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139515; c=relaxed/simple;
	bh=NWUWldiilxuF+8zG4Qi2KDmU8aOi4ClpEE92pymF1Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAF3cFScUA4WLEVh6LVq2JSxq9uF9mjmEPQtE/FtdV5xcnZrAbwQQ4KSSrjBZyoULFYsSh/CXe5LJiN0qKAfeZ29+rFF8NWMHl/cB76uEN24+8oZM8F8xQMNoOWY8jAemQVX01Rv/W5tmd+BAZL0qMUfBRcLduUu+8L+6oUVlYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1ZfUhdt; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5033387c80aso31971871cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 12:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772139512; cv=none;
        d=google.com; s=arc-20240605;
        b=lgCTb7oYc9y5izk80JsT8FckQFkmJxvb1hMO06eJe+EnPoDponb6/cQvv2vnkwAIiA
         aK7Oqb7K4xVnvtVEMSixDuO2j5vdzQ4H+xwfCKpbVuDhoGhyFxmn7ZYHIeYrtHNsEdA0
         l9RUN5Fji1lsEVoo9fEpST6roBwoQbT1bPRoGE7vdy/S+OVv57gM6IiXIbaqQCYHm6eC
         yCy89X9nkHlPjxtPSpBqKhYElpJ2uI3Wg6bxLgK9uqHIS+Qz2AUQ98YPSp3KWM2qKC0C
         wkgKd8DRW5pviTr56umTfMZxMa9ihR3Kvvr4pqUwu9aXFKOoBaRmebrFALAvDwpGPbZi
         qg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gAoboHkEOLHq4doGSCyntORfVMKmjLAt0TfIfQYkQ0Y=;
        fh=3ksfdB4b8EZVbdGlV1qSi63++7xHvQlryfyeGqGDAr8=;
        b=Hc9RGqD/1wM635uDx9n+2Wn0HHdrecRiuQc2maUvWKPfgq4d2y9S9cv3gaFZ6vz4TI
         IrnGCe52znjNEv6cwfsBZK68DwltyOlPk5WRJKWEqgMQwd3HvBSsHgAG0kc/fxRQyZkO
         Bgkyd/5EL0N8Dl8hVJKjZjkGGew9Fc2P5R4Kh+D5etNk6nXUOkJHALL7XOh/7SOyP24B
         OHZyYT2CL9L45VMTF8WpA9srHdrmTRn3Dd/wQD/qEo7pMFX6EcIhew0KOvlTf315H+i4
         M+UMoy4g4mynQWP2GQZvEAShDmPbG/zh9E+HPe2fzxKBQz1nADDtoeg1lm7M5m/FeyoM
         JKMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772139512; x=1772744312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAoboHkEOLHq4doGSCyntORfVMKmjLAt0TfIfQYkQ0Y=;
        b=R1ZfUhdtIoc87fEeyjonxgKOe5bm47VG+SWbrQwU/R58FWECi7+inGZVTqsI9rCljl
         LdbIgfh4JJ3VBoVamthVpjsDR0hiOsBJARnErJtUyyYk3xeDSEXtmU76SlYHB3zIn52A
         XYLyom5wAtFqWqnz4qxYtGWfl7c/a5loNBoFECupBkZSTStl/u+FJRc8c8MwyNewXcma
         AtHTpwyZ7L3C0dJnkvRWeRmW+goaEM6tV8H5YFoTTAUciNMebVoFSzbLKfUDfSN6I9uU
         fMmU5bKXeMuSgNdnaDn+bYWYD/6yro/N1gyOf1Hy/j+t4/Zxlikb9TmRRFGIgk0AJDfe
         +5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772139512; x=1772744312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAoboHkEOLHq4doGSCyntORfVMKmjLAt0TfIfQYkQ0Y=;
        b=G5c2dWOIVgOjHVOCAuly+h9ELnuqMN8aeiJUWcIsZDEKWuNidku9twhMJEB1PP4oz1
         FfHS6QHhu7WGtHtLnh6QfLAs8jnmgRsT4WB1Ke6okwKMZYNL1P+oXQsqvKfn79gIoCc5
         17Q2Pjh2/+Fp5aHGaxcCn76wjmVyCkDerp7HwpMBkJ1i5UJgwYNBAILUIBwjK+b7zebm
         hBo7MsgQwU1YFf+s2gHjDdKRbANCWm4Evzr+q68CshPKjSffYekRL1NQf5WjaZRHAFlU
         mK1EgBQAJgVkYLlGaF4d8r1FWcirr5MVEatSoJ3HRTi3XE8aepmATUycJ9Z2huxydExu
         xsNA==
X-Forwarded-Encrypted: i=1; AJvYcCUAvF2gsKHhLZcg6a0bdah+mGe9SfJZkK34PYkYWKvNJEwORcTbwdna8KF3/sYBS8JkbZt3qz+wj8MduZXd@vger.kernel.org
X-Gm-Message-State: AOJu0YzJp/TmKT/W++Q2Ir1nlsyGC+GItDxJqSXkE+ngMms344pj080x
	0mb34kLSrf/JJ3aaUze+3yzdHvoa8rQ6dDmUzQDpnBUWCFbLQXVb/xDKUyBTfgy5km1UfovzGXI
	b5GwN86wodt6o1i63WCUXvBAs3ztaC3VjP39gcpE=
X-Gm-Gg: ATEYQzzBrNs+7oWB/ilsTnwR8q1K54tnXSFDz89Wg+EBjUg7+IQ07O4HKJ4dd18alLu
	4s23KZJfj6L35bAVObVM8Rj6cZ2a+efOSeCfsD688PsUCbAnRszgtCjGG542PgILmig1QRHulut
	vLPpz7mfA9G1LG8e0MlNPXMAs617hwjwkR4XISloonGSLJbHXh27MIQr2Gav/5Gsdu9B/a/pGLq
	/8TYTRw3OT8n9V177NxaSsfXx/3gNC+DmxsuxqVv9ZsgaW8l0ECv5fvMjjH2nqXPGzqKTADDWr2
	VQ5ps4vjk79IXzil
X-Received: by 2002:a05:622a:40b:b0:501:3b85:272c with SMTP id
 d75a77b69052e-50752426793mr6058641cf.31.1772139512524; Thu, 26 Feb 2026
 12:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-20-joannelkoong@gmail.com> <2f14fb1a-0ee2-4d86-98be-ed6112ed706d@bsbernd.com>
 <7ccf7574-42d4-4094-9b84-eb223e73188e@bsbernd.com> <CAJnrk1b6z2oar_Zw89N275zfyU2+oZJwtozSdTPFw49x38FCOA@mail.gmail.com>
 <cb5bfa20-447d-4392-b7a5-8f7d49d70157@bsbernd.com>
In-Reply-To: <cb5bfa20-447d-4392-b7a5-8f7d49d70157@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Feb 2026 12:58:20 -0800
X-Gm-Features: AaiRm525qDFeuVkDHV2O68NT6KdqlbW3rbzn7OGNFuy8Hu2zconwXj0MEDBTi-w
Message-ID: <CAJnrk1ZQC=tE8z+D1rSnNijkMhXDPEZaB_9WL9NPZyKmG2=NSQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/25] fuse: add io-uring kernel-managed buffer ring
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, csander@purestorage.com, 
	krisman@suse.de, io-uring@vger.kernel.org, asml.silence@gmail.com, 
	xiaobing.li@samsung.com, safinaskar@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78637-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bsbernd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36B571AF580
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:21=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
> On 2/26/26 00:42, Joanne Koong wrote:
> > On Wed, Feb 25, 2026 at 9:55=E2=80=AFAM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >> On 1/28/26 22:44, Bernd Schubert wrote:
> >>> On 1/17/26 00:30, Joanne Koong wrote:
> >>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>>> @@ -940,6 +1188,7 @@ static int fuse_uring_commit_fetch(struct io_ur=
ing_cmd *cmd, int issue_flags,
> >>>>      unsigned int qid =3D READ_ONCE(cmd_req->qid);
> >>>>      struct fuse_pqueue *fpq;
> >>>>      struct fuse_req *req;
> >>>> +    bool send;
> >>>>
> >>>>      err =3D -ENOTCONN;
> >>>>      if (!ring)
> >>>> @@ -990,7 +1239,12 @@ static int fuse_uring_commit_fetch(struct io_u=
ring_cmd *cmd, int issue_flags,
> >>>>
> >>>>      /* without the queue lock, as other locks are taken */
> >>>>      fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> >>>> -    fuse_uring_commit(ent, req, issue_flags);
> >>>> +
> >>>> +    err =3D fuse_uring_headers_prep(ent, ITER_SOURCE, issue_flags);
> >>>> +    if (err)
> >>>> +            fuse_uring_req_end(ent, req, err);
> >>>> +    else
> >>>> +            fuse_uring_commit(ent, req, issue_flags);
> >>>>
> >>>>      /*
> >>>>       * Fetching the next request is absolutely required as queued
> >>>> @@ -998,7 +1252,9 @@ static int fuse_uring_commit_fetch(struct io_ur=
ing_cmd *cmd, int issue_flags,
> >>>>       * and fetching is done in one step vs legacy fuse, which has s=
eparated
> >>>>       * read (fetch request) and write (commit result).
> >>>>       */
> >>>> -    if (fuse_uring_get_next_fuse_req(ent, queue))
> >>>> +    send =3D fuse_uring_get_next_fuse_req(ent, queue, issue_flags);
> >>>> +    fuse_uring_headers_cleanup(ent, issue_flags);
> >>>> +    if (send)
> >>>>              fuse_uring_send(ent, cmd, 0, issue_flags);
> >>>>      return 0;
> >>
> >>
> >> Hello Joanne,
> >>
> >> couldn't it call fuse_uring_headers_cleanup() before the
> >> fuse_uring_get_next_fuse_req()? I find it a bit confusing that it firs=
ts
> >> gets the next request and then cleans up the buffer from the previous
> >> request.
> >
> > Hi Bernd,
> >
> > Thanks for taking a look.
> >
> > The fuse_uring_headers_cleanup() call has to happen after the
> > fuse_uring_get_next_fuse_req() call because
> > fuse_uring_get_next_fuse_req() copies payload to the header, so we
> > can't yet relinquish the refcount on the headers buffer / clean it up
> > yet. I can add a comment about this to make this more clear.
>
> I only found time right now and already super late (or early) here.
>
> I guess that is fuse_uring_copy_to_ring -> copy_header_to_ring, but why
> can it then call fuse_uring_headers_cleanup() ->
> io_uring_fixed_index_put(). I.e. doesn't it put buffer it just copied
> to? Why not the sequence of
>
> err =3D fuse_uring_headers_prep(ent, ITER_SOURCE, issue_flags);
> fuse_uring_commit(ent, req, issue_flags);
> fuse_uring_headers_cleanup(ent, issue_flags);
>
> And then fuse_uring_get_next_fuse_req() does another
> fuse_uring_headers_prep() with ITER_DEST?

The headers buffer is the same buffer for the request that's being
committed and the next request that is fetched (just like how the ent
is the same ent for the request that's committed and the next fetched
request). Because of this we can just reuse the same headers_iter and
call io_uring_fixed_index_put() after we're done copying over the next
request. I can add a comment about this to make this more clear.

>
>
> >
> >>
> >> As I understand it, the the patch basically adds the feature of 0-byte
> >> payloads. Maybe worth mentioning in the commit message?
> >
> > Hmm I'm not really sure I am seeing where the 0-byte payload gets
> > added. On the server side, they don't receive payloads that are
> > 0-bytes. If there is no next fuse request to send, then nothing gets
> > sent. But maybe I'm not interpreting your comment about 0-byte
> > payloads correctly?
>
> There is fuse_uring_req_has_payload() and
> fuse_uring_select_buffer()/fuse_uring_next_req_update_buffer() using
> that function. When a request doesn't have a payload the ring entries
> runs without a payload - effectively that introduces 0-byte payloads,
> doesn't it?

When the request doesn't have a payload, no ring entry gets used for
the request. The check for this happens in fuse_uring_prep_buffer()

static int fuse_uring_prep_buffer(struct fuse_ring_ent *ent,
                                  struct fuse_req *req, unsigned issue_flag=
s)
{
        ...
        /* no payload to copy, can skip selecting a buffer */
        if (!fuse_uring_req_has_payload(req))
                return 0;

        return fuse_uring_select_buffer(ent, issue_flags);
}

>
> >
> >> I also wonder if it would be worth to document as code comment that
> >> fuse_uring_ent_assign_req / fuse_uring_next_req_update_buffer are
> >> allowed to fail for a buffer upgrade (i.e. 0 to max-payload). At least
> >
> > Good idea, I'll add a comment about this.
> >
> >> the current comment of  "Fetching the next request is absolutely
> >> required" is actually not entirely true anymore.
> >>
> >
> > I don't think this patch introduces new behavior on this front.
> > fuse_uring_get_next_fuse_req() is still called to fetch the next
> > request AFAICS.
> >
>
> It still does, but if the request didn't have a payload it might not
> have a buffer and if it didn't have a buffer and doesn't manage to get a
> buffer, it doesn't handle a request - that a bit change of
> 'commit-and-fetch always fetches a new request if there is any request
> queued'.

Ok, I'll update the "Fetching the next request is absolutely required" comm=
ent.

Thanks,
Joanne
>
>
> Thanks,
> Bernd

