Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C8D82923
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 03:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfHFBUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 21:20:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45434 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfHFBUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:20:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so40527348pfq.12;
        Mon, 05 Aug 2019 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mtYMlQz5eR4+kIe+tAhZIY/OAiGfRw2YuZyhkg6PTbo=;
        b=I4hS4PEoJyvL+rw1aye+bkuNyFTmZHeIiI7RFxBXJ0CuNP49MtEx6c4dDp0dM/tsx/
         htvzfDxZ5r+0xq/giBKycsgk0ooQTnliw8jAdM/W7Q3ZOPIXKO2qQyyIEZllNw9fCaCK
         AFdoMHbbELxkIctqol+apII3pU0v0VXRJ+BZTJNcArgxrMpmPImidiNKJGa2PwyGiGNv
         o8knT7XYXIG+Goz56jLAprXlNR6Ro/Kzov23naZj39nZRkay4wQSSRKGepoZcGaR4LWM
         AS12+SoRSLzpL24lbVcgQ/5ahDrIgIt89rGuB5PPO3/lXQeKGmqNafdrVjeefbqsXOSG
         JgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mtYMlQz5eR4+kIe+tAhZIY/OAiGfRw2YuZyhkg6PTbo=;
        b=BRp0WiGNesg3UtanXmlWzRTp0wUgepVuHJD5ipbkYbAuGeU+B3WI2VEl+GIBxLCZsa
         ArAXwkRZFLLIVz7ssszBnxKglfIEpTZrXBgPSH7vMkr4bOmRLmt0K2C/tBwNfZGhXdWm
         qr2hJNEAfQJ+jk8ktNwvet3JQOmZK7dmj5CP7ODzUTbHWsCGL/tn4z74NH+NRlcWZF7t
         SoUuwqTLR8/xAmrlHksL3VytZFTKtZpyztpUNqHUavTKTQsKuuC/XevxP3zMts1foK09
         v1BBbZR27gUcEz1sIkmOOUt0ZVXUovXkpg/4ap5rdWsP82g4V6cemU4uEdWEsK8cETCJ
         j8IQ==
X-Gm-Message-State: APjAAAWmpkRS6UE8gdCPvT4TcblrdS+ChN4AOhV2IFmqeCT+MHHkRZm2
        BEu6eJdj01Ffo+rRTjoTmQQ=
X-Google-Smtp-Source: APXvYqyk8tVOqj3JMVpCjtlfaOGnmhUXY3kE6uE0j7jKcIcNic1rF0xLGvreX1yB+YVxBYd2ICFGvQ==
X-Received: by 2002:a62:63c7:: with SMTP id x190mr842306pfb.181.1565054432856;
        Mon, 05 Aug 2019 18:20:32 -0700 (PDT)
Received: from localhost ([175.223.3.169])
        by smtp.gmail.com with ESMTPSA id b3sm101609286pfp.65.2019.08.05.18.20.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 18:20:31 -0700 (PDT)
Date:   Tue, 6 Aug 2019 10:20:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
Message-ID: <20190806012027.GA6149@jagdpanzerIV>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
 <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
 <20190805181255.GH1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805181255.GH1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (08/05/19 19:12), Al Viro wrote:
[..]
> On Tue, Aug 06, 2019 at 01:03:06AM +0900, Sergey Senozhatsky wrote:
> > tmpfs does not set ->remount_fs() anymore and its users need
> > to be converted to new mount API.
> 
> Could you explain why the devil do you bother with remount at all?

I would redirect this question to i915 developers. As far as I know
i915 performance suffers with huge pages enabled.

> Why not pass the right options when mounting the damn thing?

vfs_kern_mount()? It still requires struct file_system_type, which
we need to get and put.

	-ss
