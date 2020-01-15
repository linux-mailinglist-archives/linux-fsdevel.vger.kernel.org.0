Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852D013BCB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgAOJrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 04:47:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52665 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgAOJrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:47:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so17109849wmc.2;
        Wed, 15 Jan 2020 01:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nKNOnYrosrVHWYJOcI6dNKAzZJvriWqZe7MstnfTsi8=;
        b=NrJaZxR0bIVGDfownDPtsbuGKg6Sh19Ib6wvkfQZZnxMgKiENkLdTOkOHkM/udnsUe
         YJrAFNZ+k0+9DSHLoXgm+X4lK8TwUrnuR73YbAB6FPgK8i21Wsock1CX8nTqZvGZw+8I
         74PGGhuCPAP4vf2oBGqZixWDONr/fzmgBjsKqLvNMNqYQwIfZgDjEdzkHCP6Gjrg1UDt
         GoSEWk5KTK13DYaERXd7Sxs+NjiL4OS0LR1zfRoMW8Ew0Nx9dHK4Sz6ZZozMX7emFCbS
         lI6+WQAMqXj/9zuHeiDVHzNTuIEAszZ2HA9SrURnV79hpfuAXHKGl4NOIojgPDMgCwCZ
         W6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nKNOnYrosrVHWYJOcI6dNKAzZJvriWqZe7MstnfTsi8=;
        b=LhtVUAzD5NQ2C6XJgidOoamjCbkBaJTHL6cgYf209+gW7JYFC55p/l0zi0yMjOpGei
         BgDfuEa/vq3DjsLISAIUFOClXyhOQB2YAkUbByEwZTFqk5xKPrzg8jfZ9tCnT4+VCn5t
         ef6WT1X/Irbe/fYUbglbkmGE/yOpQWk5zs9m9xsInaHFssA/woQzIGkO1NgirApzGsgU
         3ixnWfyrbM5IXDueEUUwi4FlxUZbKThroOX0LIJUXroiBG6yYzLIrHu3OJnyZ6fWCcEo
         zfVO+U74qj1M7gVndOnRzn1Vhg26WQPr6Ajrj+29Yn0Kn16pceGcD1zihSOsiKoHP2cf
         F6UA==
X-Gm-Message-State: APjAAAWQ/xqi4lkXM1X/PktHcHc/sM24Km71a4yKd4AVZqZgxhc3xvvl
        37zG+j8eQ1GCk8gIV9xfC8k=
X-Google-Smtp-Source: APXvYqwJVnvp6j3pOYcsUjqzrpn2BV52RqMZOOodn63BQh/zlXGPtaFafJxUgUdE+OFSPJVHBze+eA==
X-Received: by 2002:a1c:7dc4:: with SMTP id y187mr31685636wmc.161.1579081653593;
        Wed, 15 Jan 2020 01:47:33 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b10sm24468574wrt.90.2020.01.15.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 01:47:33 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:47:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 00/14] add the latest exfat driver
Message-ID: <20200115094732.bou23s3bduxpnr4k@pali>
References: <CGME20200115082818epcas1p4892a99345626188afd111ee263132458@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello! I have reviewed all changes in time when v10 has been preparing.

There is just a small issue with description of EXFAT_DEFAULT_IOCHARSET
option (see email). Otherwise it looks good you can add my Reviewed-by
on whole patch series.

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

Next steps for future:

* De-duplicate cache code between fat and exfat. Currently fs/exfat
  cache code is heavily copy-paste of fs/fat cache code.

* De-duplicate UTF-16 functions. Currently fs/exfat has e.g. helper
  functions for surrogate pairs copy-paste from fs/nls.

* Unify EXFAT_DEFAULT_IOCHARSET and FAT_DEFAULT_IOCHARSET. Or maybe
  unify it with other filesystems too.

* After applying this patch series, remote staging exfat implementation.

-- 
Pali Rohár
pali.rohar@gmail.com
