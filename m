Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA18AB35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 01:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfHLXdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 19:33:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36148 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfHLXdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:33:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so50487536pfl.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTfhhIMEVWBJ1fQ8dSU/yBqkpCSWczjteIKFZOpbLX8=;
        b=c9dOYm8jUrYmRfI5dEYJE2Wdnda5vlKFp8TRu/bv1paeS5Nb3I93x9HcYZ5ednOIno
         wGUiE4FUkpp0oe3pnvKv6pG5E0pSyHTSelc+rec86VL0eKpaX1nLvJb20gWSbR51tasf
         pgzzqgph/ELjX9q8SLyXYbEtVD5OMe2Bv9/Yd1k25uiMzejzz4xG8apO6djfJpMz8vcn
         XxJ7D8O/Gc8sfv/yWGdO+KIi2sqttmFcaUq9dKaYH8/xsyQWTJSFN1Jmxc4txyx4aB+z
         WGBS3gigW8iS9W0dFVg6j9MrUrNTENxkLxw6lLoD3AWXnMP8qmgG1uCcjQTNKLdPM7ys
         zaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTfhhIMEVWBJ1fQ8dSU/yBqkpCSWczjteIKFZOpbLX8=;
        b=WVl3Lmqo7oyPEXdAiaDhRqfuEzLeEw3/QPMRNCUPJ6eDfF0jIfuztlbW9JLEyDcVEX
         hfvjZGgrPiH0duWfr/4UwtS0SXgUssgLtx8BvBEG2A3tZEZHoWhucQTtMqCHoA1JC7Cd
         Ph2VjZjjNxtc9Qw1Y9kajwBk4L14l5oiuD9/J3iNyGSOs2tkeTtk3E8SI+ayf3ejq7S/
         Qbuk7/3Jynn6vF0HV7WAAc7y3zcERtBS8GMgh3+qZDYm1aCc99FgdCTcX5mRfiYJxJLp
         R0y0VP8+awz58KL6ZKz5+cocPWGlNHoPrhZ66PSIdUyHZ4qaoTvh9Hutsv+ntUNVXaTr
         oSzw==
X-Gm-Message-State: APjAAAXTaQ0KJPKDBNQV6JE0GrV5AoAj5x65Ft/lmFv/WuHzE/z4ssDu
        dg48yPRsMb1CCzAQA7akxFNX9g==
X-Google-Smtp-Source: APXvYqxcDoap4N3EkfxGt7+4TrFgEHcuwub7I5n6cGzvsvHggQpTuDBEDm80K9tY5UT8aKNLpSv+9A==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr31927403pgq.415.1565652822096;
        Mon, 12 Aug 2019 16:33:42 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id j187sm13658683pfg.178.2019.08.12.16.33.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:33:41 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:33:36 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
Message-ID: <20190812233336.GA224410@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812225520.5A67C206A2@mail.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 03:55:19PM -0700, Stephen Boyd wrote:
> Quoting Brendan Higgins (2019-08-12 11:24:06)
> > +void string_stream_clear(struct string_stream *stream)
> > +{
> > +       struct string_stream_fragment *frag_container, *frag_container_safe;
> > +
> > +       spin_lock(&stream->lock);
> > +       list_for_each_entry_safe(frag_container,
> > +                                frag_container_safe,
> > +                                &stream->fragments,
> > +                                node) {
> > +               list_del(&frag_container->node);
> 
> Shouldn't we free the allocation here? Otherwise, if some test is going
> to add, add, clear, add, it's going to leak until the test is over?

So basically this means I should add a kunit_kfree and
kunit_resource_destroy (respective equivalents to devm_kfree, and
devres_destroy) and use kunit_kfree here?

> > +       }
> > +       stream->length = 0;
> > +       spin_unlock(&stream->lock);
> > +}
> > +
