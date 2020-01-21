Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE4143B87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 12:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAULAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 06:00:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45359 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgAULAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:00:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so2605192wrj.12;
        Tue, 21 Jan 2020 03:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1yHO78BlmD5ePF7vR6G6f3SYtNqfwsMJwSdjTduHry8=;
        b=qqbRpNcLc+Hp9q2HHXLmzIqC+zsFFJMfWtlb69Hk9/vjCrnU2ql5Qwq2CMgIdQUxon
         46Fpn1KwV1EXe2WaOp6JJCs8E6I03QzDKCigqQe2HseeRpJk0Xhl//evdoBU//rN9uJc
         t8CzqxjItvYXPnf/ttUf6iO/xn7EjfiQE2skV1RD68PICHwQYe6kRaG5K2PFyiZeVCaR
         NXc/SvbN0uOoCuW7mwOlM9mD5XGy6dRLy9wcMKPc4PhInPTpxUb1pHHVaQ5KgDA+DCwx
         bUYl0NTrJQRe5RgtEadrjqtXXo6iLtkrEKxJHoHKLpr7li8CWkdNeAq29IH9E6JQ1+lt
         KkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1yHO78BlmD5ePF7vR6G6f3SYtNqfwsMJwSdjTduHry8=;
        b=XqAbCTJeMd2jDBbOZ15laDQaRNRlITrzBuroPqzulqknj1sQn9l6h9iEum9YnJ1CbO
         AX9wX1Hf1c99Z1TLL6pFRKzCijy71kw+qBRb+qRZOpmyfC6vXDRBrUkd2KKMuw6mt8Qg
         GmbWLXGhQuuBZLNdLJaHsoTZhRddCbsCveY+59H5Sze0iJoFY9Po132Y3xZ1z0z/vbuU
         tYcRihBdqxmUBw5s6d+wep4m/QgrAbXoAl/h7i4mipwREmUVqRrvOa1m9M3iRvKZ0Z0c
         t61wz44esJvBLLFU1hs13imH0SGVdqkh5lnQdq01rEe4e6SJBPkVnELppoLYBOu/4h4w
         UPkA==
X-Gm-Message-State: APjAAAWUlr+wRRJkgifGdCj+GShwfcnbnhyqvaK5nyeFl7pxGSBwQR5o
        a1wCzC2BPUz1WsOzgVFIyl0=
X-Google-Smtp-Source: APXvYqyHts9oIQp+L9m14UxOXzol1XEhlCbUwKMiRBQmIvCbb8SXYmjeyMR1B7fxUn3Im8JOdEh8pA==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr4750352wrn.251.1579604451026;
        Tue, 21 Jan 2020 03:00:51 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u22sm54596665wru.30.2020.01.21.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 03:00:50 -0800 (PST)
Date:   Tue, 21 Jan 2020 12:00:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200121110049.4upreexmv5kxwp5n@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120173215.GF15860@mit.edu>
 <87eevt4ga5.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eevt4ga5.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 21 January 2020 12:52:50 OGAWA Hirofumi wrote:
> BTW, VFAT has to store the both of shortname (codepage) and longname
> (UTF16), and using both names to open a file. So Windows should be using
> current locale codepage to make shortname even latest Windows for VFAT.

fastfat.sys stores into shortnames only 7bit characters. Which is same
in all OEM codepages. Non-7bit are replaced by underline or shortened by
"~N" syntax. According to source code of fastfat.sys it has some
registry option to allow usage also of full 8bit OEM codepage.

So default behavior seems to be safe.

-- 
Pali Rohár
pali.rohar@gmail.com
