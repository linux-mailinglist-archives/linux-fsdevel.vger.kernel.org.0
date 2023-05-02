Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288C6F3C24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 04:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjEBCWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 22:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjEBCWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 22:22:35 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E931C40C5;
        Mon,  1 May 2023 19:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1682994147;
        bh=XleaLi6oRjXtfe2D7RhL/bXb9kAyYfGf1xyiXtDlQDk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=B3+pvvNt1nRN8hRoSXjf3I4ybVi/EDboNnvLeMqv3k3o/5KuewFLsQ2LIIO45T87D
         dmw9Bza7VZEKEtygO+CQeSy7CBK508rzVVZKe8uhSLnG5n4AwGQmHHjTyQBjyKut87
         W4mECobpPwTueeG1X8Y0LfbxM9hzHFolb5i0L6ew=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 554B4128648F;
        Mon,  1 May 2023 22:22:27 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id XSNGV24ZawPq; Mon,  1 May 2023 22:22:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1682994146;
        bh=XleaLi6oRjXtfe2D7RhL/bXb9kAyYfGf1xyiXtDlQDk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=m6bYz5hNQXdxoZ5NOAcJ2JFL0kL9SDAdXRGd+EFNCj+3OnfQ3+swh//Kmg4+1ZxnT
         /vAaVHfPpqrg0q8i1pJguyqq2gnSLJOdqlrDbhqXY73Dx/2yBSTryYz6FylsmhHOQk
         kWyP5cXIJTuLLvuvIQl6DHYlZBed/Vghiiim+rwE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 25B2E1285C64;
        Mon,  1 May 2023 22:22:21 -0400 (EDT)
Message-ID: <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in
 string_get_size's output
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Noralf =?ISO-8859-1?Q?Tr=EF=BF=BDnnes?= <noralf@tronnes.org>
Date:   Mon, 01 May 2023 22:22:18 -0400
In-Reply-To: <ZFAUj+Q+hP7cWs4w@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
         <20230501165450.15352-2-surenb@google.com>
         <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
         <ZFAUj+Q+hP7cWs4w@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-01 at 15:35 -0400, Kent Overstreet wrote:
> On Mon, May 01, 2023 at 11:13:15AM -0700, Davidlohr Bueso wrote:
> > On Mon, 01 May 2023, Suren Baghdasaryan wrote:
> > 
> > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > 
> > > Previously, string_get_size() outputted a space between the
> > > number and the units, i.e.
> > >  9.88 MiB
> > > 
> > > This changes it to
> > >  9.88MiB
> > > 
> > > which allows it to be parsed correctly by the 'sort -h' command.
> > 
> > Wouldn't this break users that already parse it the current way?
> 
> It's not impossible - but it's not used in very many places and we
> wouldn't be printing in human-readable units if it was meant to be
> parsed - it's mainly used for debug output currently.

It is not used just for debug.  It's used all over the kernel for
printing out device sizes.  The output mostly goes to the kernel print
buffer, so it's anyone's guess as to what, if any, tools are parsing
it, but the concern about breaking log parsers seems to be a valid one.

> If someone raises a specific objection we'll do something different,
> otherwise I think standardizing on what userspace tooling already
> parses is a good idea.

If you want to omit the space, why not simply add your own variant?  A
string_get_size_nospace() which would use most of the body of this one
as a helper function but give its own snprintf format string at the
end.  It's only a couple of lines longer as a patch and has the bonus
that it definitely wouldn't break anything by altering an existing
output.

James

