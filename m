Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE15134476
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 15:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgAHOBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 09:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgAHOBl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:01:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874F720705;
        Wed,  8 Jan 2020 14:01:39 +0000 (UTC)
Date:   Wed, 8 Jan 2020 09:01:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/22] bootconfig: Add Extra Boot Config support
Message-ID: <20200108090138.4fd561ac@gandalf.local.home>
In-Reply-To: <20200108141700.425599efe7ab0ac7c4329661@kernel.org>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
        <157736904075.11126.16068256892686522924.stgit@devnote2>
        <20200107205945.63e5d35a@rorschach.local.home>
        <20200108141700.425599efe7ab0ac7c4329661@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Jan 2020 14:17:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > +}
> > > +
> > > +/**
> > > + * xbc_node_is_key() - Test the node is a key node
> > > + * @node: An XBC node.
> > > + *
> > > + * Test the @node is a key node and return true if a key node, false if not.
> > > + */
> > > +static inline __init bool xbc_node_is_key(struct xbc_node *node)
> > > +{
> > > +	return !(node->data & XBC_VALUE);
> > > +}
> > > +  
> 
> Maybe this is better use xbc_node_is_value()
> 
> 	return !xbc_node_is_value();
> 
> Right?

Agreed.

-- Steve

> 

