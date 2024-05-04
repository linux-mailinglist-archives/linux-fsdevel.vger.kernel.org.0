Return-Path: <linux-fsdevel+bounces-18710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE08BB982
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 06:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C8B22E3C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 04:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A34C79;
	Sat,  4 May 2024 04:49:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215E368;
	Sat,  4 May 2024 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714798189; cv=none; b=tWcHee1EQJ2WEYk19TnjYgNA0E4wloWMoOLv3bLqDV3QHW9Dsv7WDgriY19aDoFDcR8zLsJcOg278AX+//hW0cseJcypvPMILIdqfXtKWYY3nWPPPdkckqXPDYizFWYGrcnwapXX1TdMP2pucgcdlK+jtD8pUa/sVORlDUPRJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714798189; c=relaxed/simple;
	bh=AZVXknqp80uNFd8VybaljWByNK6UQCNehWnnHaS7G0A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=swsAi+5xakTY0cDL+tZfFX0uHHW+F4PP66QFbKu/oSAV3444YFiMsalOl5ofT6ocr1LKLEIdg+Lzwj95Go3+TbUggA/w07VxX64LErqJ5h/jxBA12MCXw/QCzp93dM5QpEWOxv8Qyq5wQjFXa5lU5O+j61xPjo+zN7mitU8tf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=valtier.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=valtier.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de60380c04aso407723276.2;
        Fri, 03 May 2024 21:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714798187; x=1715402987;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHLa8FlW4Yvbca+CsP0omcGEpUmDjfstJmGOttvUc+k=;
        b=vh5BevOAcGJ0Qdn5kZhx0IVZ+KGxFhITEQh/pagsKUUzUuR+/AgIW2sSKPomDOiewb
         6qdp33HUYzltlyQBoXue8XP/R8NJUcdFCzU+JmpwiUFzlsrtuDXvulIZH+6h+uZx9Th1
         DaoAaMBWIRx10Y14Jh7EDxVJ4RKK6o4U/oxZQweC5IPU/ZjzaUVExmOOxIeCiZrt1UNM
         Om2XMPX/GP9NaPUGuBjT+DtIiY4BeUYx/pqCaYyFuepOPVnwPeGA1wp26fmemTwfkNrc
         T0ykoDxhAY/Tdnw9YxG3gKwMoSkDPEUPNdSurQccJWTWGkTSh4PkY6zXf7pLTwUL70Xz
         CxNg==
X-Forwarded-Encrypted: i=1; AJvYcCVSAnxiSbNunU7l5tgX2xVWdRHPEhN9us4EWpe4H27bOGWh1EKXFEDi1bLri7Y7ECt0s+yEXDYCi2s16dOQUNeIgNCnl9pCLOMp9L3zwoYKAI6wADQ7TIBf0mYq2gctjAN8Yn9no8oQUUhgtQ==
X-Gm-Message-State: AOJu0Yy7URl1cxYTrHcl9GmdWKFHZZz93613uKqrgaTjMvjZ9m+RYlCL
	8d1FMYSuR09q78wrmu6oxp7B6s1s6/AGSmUI/gzNtxkU/tBpIF/9NtlyZ7JsY0LuuPZORw1BXLL
	xpoaJtPDUloN5LfqBIqHyl/h0o5w=
X-Google-Smtp-Source: AGHT+IFuxYMowE/rEgP7jq9G1X7AWt3AD3RDfb3h2QN/vujOHFX5Cs35uCKSvIeb4Io7piLfiBXGFRIoYwGTNTFt9Rw=
X-Received: by 2002:a25:c74e:0:b0:de5:4b25:8054 with SMTP id
 w75-20020a25c74e000000b00de54b258054mr4466918ybe.65.1714798187040; Fri, 03
 May 2024 21:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hugo Valtier <hugo@valtier.fr>
Date: Sat, 4 May 2024 06:49:16 +0200
Message-ID: <CAF+WW=oKQak6ktiOH75pHSDe7YEkYD-1ditgcsWB=z+aRKJogQ@mail.gmail.com>
Subject: bug in may_dedupe_file allows to deduplicate files we aren't allowed
 to write to
To: mfasheh@suse.de, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For context I am making a file based deduplication tool.

I found that in this commit
5de4480ae7f8 ("vfs: allow dedupe of user owned read-only files")
it states:
> - the process could get write access

However the behavior added in allow_file_dedupe now may_dedupe_file is opposite:
> +       if (!inode_permission(file_inode(file), MAY_WRITE))
> +               return true

I've tested that I can create an other readonly file as root and have
my unprivileged user deduplicate it however if I then make the file
other writeable I cannot anymore*.
It doesn't make sense to me why giving write permissions on a file
should remove the permission to deduplicate*.

I'm not sure on how to fix this, flipping the condition would work but
that is a breaking change and idk if this is ok here.
Adding a check to also users who have write access to the file would
remove all the logic here since you would always be allowed to dedup
FDs you managed to get your hands on.

Any input on this welcome, thx

*without opening the file in write mode which I don't want to do
because it can prevent execution of files which is the exact thing is
5de4480ae7f8 were trying to address in the first place

