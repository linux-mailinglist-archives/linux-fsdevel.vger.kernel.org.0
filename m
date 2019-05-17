Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF48220CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 01:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfEQXtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 19:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfEQXtb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 19:49:31 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A7C2166E;
        Fri, 17 May 2019 23:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558136971;
        bh=1cAj3EpfnGuZrLoS21aG9XcqUSakxJ9S2o4OX5+SOo0=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=j7riZRc5kG6qLeP3pF9iKvp5HDM7Cr3yQJauxH4Mopvvu8HdnCVjnzBcXYq0TOMwa
         wSB7VAppG5HoDcjyBIxmqpTN9VptZhjBF1WkO88x3d7MY6SihB7quZpqZntGMHOQ4u
         nDtoWhtpbOxMAcs+7nkvm9Z/0pEEvMuUd3U4ak3A=
Date:   Fri, 17 May 2019 16:49:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/22] coda: remove uapi/linux/coda_psdev.h
Message-Id: <20190517164930.9c2b62b7b466e7380b168635@linux-foundation.org>
In-Reply-To: <20190517162951.79c957039dd6cbb9b7d5b791@linux-foundation.org>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
        <bb11378cef94739f2cf89425dd6d302a52c64480.1558117389.git.jaharkes@cs.cmu.edu>
        <20190517162951.79c957039dd6cbb9b7d5b791@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 17 May 2019 16:29:51 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 17 May 2019 14:36:54 -0400 Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> 
> > Nothing is left in this header that is used by userspace.
> > 
> >  fs/coda/coda_psdev.h            |  5 ++++-
> >  include/uapi/linux/coda_psdev.h | 10 ----------
> 
> Confused.  There is no fs/coda/coda_psdev.h.  I did this.  It compiles
> OK...
> 

Is OK, I sorted it out.  I'm still recovering from an email server
glitch :(
