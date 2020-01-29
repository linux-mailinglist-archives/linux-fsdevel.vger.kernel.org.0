Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF05A14CF87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgA2RU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:20:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39851 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726906AbgA2RU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580318427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cQH6ZYTqwW+stKfQ8AjSjdZ36iZukpGr3cI8BWThvC4=;
        b=RJy/stPIJHS80u/ApwJQ8dW0WrLsqTkQnrt/TidKxvHBzcTMllHI+sQNn0I6rD87NTnYah
        zfWwiLX3KW56oFRDCpnwSxEm/BeW1fywkfETdODtC5ODdiIN7BlynEeorKcD0WY04kwEvR
        A3gNBNBU/U4h+IbepT6vOOSsDNStmL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-vKpp2hkHOK6vd_qVuq69pQ-1; Wed, 29 Jan 2020 12:20:03 -0500
X-MC-Unique: vKpp2hkHOK6vd_qVuq69pQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3CFA1010418;
        Wed, 29 Jan 2020 17:20:00 +0000 (UTC)
Received: from treble (ovpn-120-83.rdu2.redhat.com [10.10.120.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D43CF60C85;
        Wed, 29 Jan 2020 17:19:58 +0000 (UTC)
Date:   Wed, 29 Jan 2020 11:19:56 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-01-28-20-05 uploaded (objtool warnings)
Message-ID: <20200129171956.wlwz5gr6fva5iae7@treble>
References: <20200129040640.6PNuz0vcp%akpm@linux-foundation.org>
 <5f2400c0-3d9d-9bfd-315e-a26bedb165a7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f2400c0-3d9d-9bfd-315e-a26bedb165a7@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 08:43:35AM -0800, Randy Dunlap wrote:
> On 1/28/20 8:06 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-01-28-20-05 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> 
> on x86_64: (duh)
> 
> > gcc --version
> gcc (SUSE Linux) 7.5.0
> 
> 
> fs/namei.o: warning: objtool: do_renameat2()+0x46d: unreachable instruction
> kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x2b: unreachable instruction
> drivers/iio/adc/vf610_adc.o: warning: objtool: vf610_set_conversion_mode()+0x4e: unreachable instruction
> 
> 
> Full randconfig file is attached.
> 
> Do you want the .o files, Josh?

I'm able to recreate with your config, so I don't need the .o files.

Thanks.

-- 
Josh

