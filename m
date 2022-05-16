Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE175288E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245154AbiEPPa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiEPPay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 11:30:54 -0400
X-Greylist: delayed 499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 08:30:47 PDT
Received: from mail-ogi-t60-f221.ogicom.net (mail-ogi-t60-f221.ogicom.net [213.108.60.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DA60D1;
        Mon, 16 May 2022 08:30:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail43.ogicom.net (Postfix) with ESMTP id 37F76150C0625;
        Mon, 16 May 2022 17:22:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail43.ogicom.net
Received: from mail43.ogicom.net ([127.0.0.1])
        by localhost (mail43.ogicom.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oU34Nk2aGn26; Mon, 16 May 2022 17:22:19 +0200 (CEST)
Received: from linux-m4k8.home (62-69-247-172.internetia.net.pl [62.69.247.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kb@sysmikro.com.pl)
        by mail43.ogicom.net (Postfix) with ESMTPSA id 74419150C06AD;
        Mon, 16 May 2022 17:22:19 +0200 (CEST)
Message-ID: <1652713968.3497.416.camel@sysmikro.com.pl>
Subject: Re: [PATCH] freevxfs: relicense to GPLv2 only
From:   Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@sysmikro.com.pl>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-spdx@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 May 2022 17:12:48 +0200
In-Reply-To: <20220516133825.2810911-1-hch@lst.de>
References: <20220516133825.2810911-1-hch@lst.de>
Organization: Systemy mikroprocesorowe
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Acked-by: Krzysztof Błaszkowski <kb@sysmikro.com.pl>

On Mon, 2022-05-16 at 15:38 +0200, Christoph Hellwig wrote:
> When I wrote the freevxfs driver I had some odd choice of licensing
> statements, the options are either GPL (without version) or an odd
> BSD-ish licensense with advertising clause.
> 
> The GPL vs always meant to be the same as the kernel, that is version
> 2 only, and the odd BSD-ish license doesn't make much sense.  Add
> a GPL2.0-only SPDX tag to make the GPL intentions clear and drop the
> bogus BSD license.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
>  fs/freevxfs/vxfs.h        | 27 +--------------------------
>  fs/freevxfs/vxfs_bmap.c   | 26 +-------------------------
>  fs/freevxfs/vxfs_dir.h    | 27 +--------------------------
>  fs/freevxfs/vxfs_extern.h | 27 +--------------------------
>  fs/freevxfs/vxfs_fshead.c | 26 +-------------------------
>  fs/freevxfs/vxfs_fshead.h | 27 +--------------------------
>  fs/freevxfs/vxfs_immed.c  | 26 +-------------------------
>  fs/freevxfs/vxfs_inode.c  | 26 +-------------------------
>  fs/freevxfs/vxfs_inode.h  | 27 +--------------------------
>  fs/freevxfs/vxfs_lookup.c | 26 +-------------------------
>  fs/freevxfs/vxfs_olt.c    | 26 +-------------------------
>  fs/freevxfs/vxfs_olt.h    | 27 +--------------------------
>  fs/freevxfs/vxfs_subr.c   | 26 +-------------------------
>  fs/freevxfs/vxfs_super.c  | 26 +-------------------------
>  14 files changed, 14 insertions(+), 356 deletions(-)
> 
> diff --git a/fs/freevxfs/vxfs.h b/fs/freevxfs/vxfs.h
> index a41ea0ba69433..bffd156d6434c 100644
> --- a/fs/freevxfs/vxfs.h
> +++ b/fs/freevxfs/vxfs.h
> @@ -1,32 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
>   * Copyright (c) 2016 Krzysztof Blaszkowski
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
> - *
>   */
>  #ifndef _VXFS_SUPER_H_
>  #define _VXFS_SUPER_H_
> diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
> index 1fd41cf98b9fc..de2a5bccb9307 100644
> --- a/fs/freevxfs/vxfs_bmap.c
> +++ b/fs/freevxfs/vxfs_bmap.c
> @@ -1,30 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
>   */
>  
>  /*
> diff --git a/fs/freevxfs/vxfs_dir.h b/fs/freevxfs/vxfs_dir.h
> index acc5477b3f232..fbcd603365ad6 100644
> --- a/fs/freevxfs/vxfs_dir.h
> +++ b/fs/freevxfs/vxfs_dir.h
> @@ -1,31 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
> - *
>   */
>  #ifndef _VXFS_DIR_H_
>  #define _VXFS_DIR_H_
> diff --git a/fs/freevxfs/vxfs_extern.h b/fs/freevxfs/vxfs_extern.h
> index f5c428e210245..3a2180c5e208d 100644
> --- a/fs/freevxfs/vxfs_extern.h
> +++ b/fs/freevxfs/vxfs_extern.h
> @@ -1,31 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
> - *
>   */
>  #ifndef _VXFS_EXTERN_H_
>  #define _VXFS_EXTERN_H_
> diff --git a/fs/freevxfs/vxfs_fshead.c b/fs/freevxfs/vxfs_fshead.c
> index a4610a77649e5..c1174a3f89905 100644
> --- a/fs/freevxfs/vxfs_fshead.c
> +++ b/fs/freevxfs/vxfs_fshead.c
> @@ -1,31 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
>   * Copyright (c) 2016 Krzysztof Blaszkowski
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
>   */
>  
>  /*
> diff --git a/fs/freevxfs/vxfs_fshead.h b/fs/freevxfs/vxfs_fshead.h
> index e026f0c491596..dfd2147599c49 100644
> --- a/fs/freevxfs/vxfs_fshead.h
> +++ b/fs/freevxfs/vxfs_fshead.h
> @@ -1,32 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
>   * Copyright (c) 2016 Krzysztof Blaszkowski
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
> - *
>   */
>  #ifndef _VXFS_FSHEAD_H_
>  #define _VXFS_FSHEAD_H_
> diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
> index bfc780c682fb8..334822dd8dbef 100644
> --- a/fs/freevxfs/vxfs_immed.c
> +++ b/fs/freevxfs/vxfs_immed.c
> @@ -1,30 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
>   */
>  
>  /*
> diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
> index 1f41b25ef38b2..ceb6a12649ba6 100644
> --- a/fs/freevxfs/vxfs_inode.c
> +++ b/fs/freevxfs/vxfs_inode.c
> @@ -1,31 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
>   * Copyright (c) 2016 Krzysztof Blaszkowski
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
>   */
>  
>  /*
> diff --git a/fs/freevxfs/vxfs_inode.h b/fs/freevxfs/vxfs_inode.h
> index f012abed125d6..1e9e138d2b338 100644
> --- a/fs/freevxfs/vxfs_inode.h
> +++ b/fs/freevxfs/vxfs_inode.h
> @@ -1,32 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
>   * Copyright (c) 2016 Krzysztof Blaszkowski
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
> - *
>   */
>  #ifndef _VXFS_INODE_H_
>  #define _VXFS_INODE_H_
> diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
> index a51425634f659..f04ba2ed1e1aa 100644
> --- a/fs/freevxfs/vxfs_lookup.c
> +++ b/fs/freevxfs/vxfs_lookup.c
> @@ -1,31 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
>   * Copyright (c) 2016 Krzysztof Blaszkowski
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
>   */
>  
>  /*
> diff --git a/fs/freevxfs/vxfs_olt.c b/fs/freevxfs/vxfs_olt.c
> index 813da66851510..23f35187c2896 100644
> --- a/fs/freevxfs/vxfs_olt.c
> +++ b/fs/freevxfs/vxfs_olt.c
> @@ -1,30 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
>   */
>  
>  /* 
> diff --git a/fs/freevxfs/vxfs_olt.h b/fs/freevxfs/vxfs_olt.h
> index 0c0b0c9fa5579..53afba08d617f 100644
> --- a/fs/freevxfs/vxfs_olt.h
> +++ b/fs/freevxfs/vxfs_olt.h
> @@ -1,31 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
> - *
>   */
>  #ifndef _VXFS_OLT_H_
>  #define _VXFS_OLT_H_
> diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
> index e806694d4145e..ae19e315788d3 100644
> --- a/fs/freevxfs/vxfs_subr.c
> +++ b/fs/freevxfs/vxfs_subr.c
> @@ -1,30 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
>   */
>  
>  /*
> diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
> index 22eed5a73ac24..c3b82f716f9a7 100644
> --- a/fs/freevxfs/vxfs_super.c
> +++ b/fs/freevxfs/vxfs_super.c
> @@ -1,31 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2000-2001 Christoph Hellwig.
>   * Copyright (c) 2016 Krzysztof Blaszkowski
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or
> without
> - * modification, are permitted provided that the following
> conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. The name of the author may not be used to endorse or promote
> products
> - *    derived from this software without specific prior written
> permission.
> - *
> - * Alternatively, this software may be distributed under the terms
> of the
> - * GNU General Public License ("GPL").
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS
> IS'' AND
> - * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> THE
> - * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> PARTICULAR PURPOSE
> - * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
> LIABLE FOR
> - * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> CONSEQUENTIAL
> - * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
> GOODS
> - * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> INTERRUPTION)
> - * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> CONTRACT, STRICT
> - * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
> ANY WAY
> - * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> POSSIBILITY OF
> - * SUCH DAMAGE.
>   */
>  
>  /*
-- 
Krzysztof Blaszkowski
