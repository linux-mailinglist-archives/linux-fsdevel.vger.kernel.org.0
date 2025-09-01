Return-Path: <linux-fsdevel+bounces-59855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E853AB3E676
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC620572B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47034165A;
	Mon,  1 Sep 2025 13:58:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96733CE8E;
	Mon,  1 Sep 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735121; cv=none; b=p8myWMRv021lBeeFX36nJctacuR2N0Fc8JxpJah+XfSwCAfc6CvRcWUeFGW+/Gj9fPN3JjBHpvrCmIj+yYtFaQGMv5eU8LY0MW37uzRA/zdqWzNzIIMWTQ1yZvumcpVy7vzgG6LkAOWgVrvcbvTmXEK4vwI2Nv+ljPY4lzw9usM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735121; c=relaxed/simple;
	bh=oUIhwrLYwstlzlY55FK1ZW41MS2asLYsST3xVM4ctTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmMOEnLWS5DUAxAXIHggxgGsFCo6JdM2ALfcpCibpy0SGTw14eqETYC+W3usYj3GY5L+1+HSZB/iMHh2glZ9jTkb9Q7Vv01E70AsoBSKMAUea7QHOrmBMoLxGwjlUT0Jkb21Sfwf9so6ub2QIhrzcbd6Jv8sL+15y97HrprQnug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ea8b3a64b5so37258755ab.2;
        Mon, 01 Sep 2025 06:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735118; x=1757339918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmDip3pK7R1bCI3jhASK9yPIU2OeMFz+fVnQvMU5RZM=;
        b=ookCPzvg4cb5ovsdKebhU9K1Jellm/G19uG0vP9BQQd5+2BvVH/x/LbzCj/FX3czQU
         D56X+ZNQR7t7AVnlBd956tJMelVCbbrRJGozIquP7a//oFufEZ0nAPJPay1Cjy3MPG3W
         opeW/AwAjHbpXcaPkhEMhyjYURdxax0GksqLu3ku76N3QQhkljfXw23BRWrgqNoC0GPO
         nYSHznM2/yatV/Py7Ad9ScpoRF3Tdc9qERGrKCrCmXaMxY/cWl9X/3vhazam6F41YZTC
         kgVW6itpB1+DuYTrG64iiKVbNdK9wG2GLajqrGfhVbcs6p0uTM72mdNfRYEB8U9/Nsy2
         TPbA==
X-Forwarded-Encrypted: i=1; AJvYcCUPk72/MJ1XL3orkt1h30T5dNqDAG1qze7Ps6g0NLrj8nImuVqFVYOTYHZQp4W2X5SZyJ8FeKOD/6qkD6cht9k=@vger.kernel.org, AJvYcCVmSHHSt0VVUuLIVw0i8yLvBfUJw2EhT3oKbfHEnyuFrkXS1+z49GCGRPz99IAhnr6GqfhqLDGopU9JGZjW@vger.kernel.org, AJvYcCVnrDmBmUXjqoQGDIMhoMipYV/LX5YaskjBvZOpPmEdqk2u4Rm3oiE/ErkIbAKeNT4+g0W3Ba7gJIXPwA==@vger.kernel.org, AJvYcCWJ/QPcMNYaQAF0GSkT8o4Cml92E+oPD/FCUCVuqUJ+bI+dvZAkYTTlZgdUNueRcib0zmIJG0khaGzgTpXP@vger.kernel.org, AJvYcCWJOwfMQy0qWS3M9oRdV9FNrUl7qPanIqNpnQkL+OOLqliwzB3tob4ZUD6rtSpnLa0uchOag+jZEmfygQ==@vger.kernel.org, AJvYcCWq0KyV93N6QOXX1OrDyT1klUvQ26lgsdAF37wkwJAQLXnr2pQQVDhwcJO4xm+pe53Yd+CcVMZ+7Ql1Zb8=@vger.kernel.org, AJvYcCWrQAYj8WGWxIR7AUxBgeWBPxKjrBdvdcflvQrq+mj1lItZCZnHZJCwjjk4T+2PjB7GRJyn/tAp@vger.kernel.org, AJvYcCWsduK2I9NsCHHGe5HItJOxFRex8ufP21bnwGEtPtynq7ZzPs3aqWNiftxK9W6DNxffoUqKuFafsp2MlU4=@vger.kernel.org, AJvYcCX+v0Gn/VSMF8kaFdc21KTXDdyJqZzeg/kwfVIIr3mNvEZ+uC5Nc5bLdGcFE+vwiInmKO0iQvhtkA==@vger.kernel.org, AJvYcCX0Dn1kBR7hrJOAciV1
 qKjHqcnS5MXJAAhc4sgEOPZE/JY3XuIdaFf9qjYPuxZ5ZV+Qk8vWCvm9@vger.kernel.org, AJvYcCXBEbf5r102sOi+/VhZEgxB8NTRa5AJMJRlmaTRlvrM9ERsZH+/6UrQJxe/1c9o6+gurzx7aAKqw//85Q==@vger.kernel.org, AJvYcCXEDC2OdkZbDzDZ3Jqp/dx3nhb2cBTRwIr1ROGDMF4AP8TOnU3RueUZb0qSYav73wSbdll5XEozbp1RDA==@vger.kernel.org, AJvYcCXGW+ChK4FRj6QsFSo4YvUb2sRNw9YHJvJqTHsZt7AOmuwDDjXiThnsNZLn9GZMD8KIY72brkgfqdjz1DfDrQ==@vger.kernel.org, AJvYcCXNb9gJWF099r/WlJ1U4rkeEbZrflQ2STzzvSSQCcghkie2xVoKCx1uCWXdrEz5JASBr8kBXmGizUM=@vger.kernel.org, AJvYcCXOnpq0fM1hPHETsIvAEp/fFtS6s1HtQB//tCqJxxK4MBI68hTqZnW1fsX+R4PSxEOvv6fBuWvipGME6r2fvT7nVOOClU4R@vger.kernel.org, AJvYcCXYAiRGiLEB4I5uZCecFQWCWyPlBk33XCItexigMxdnGZU+OP9tuL7UbBLnTFtUKVaQgrkLxBHp2ihAdwq9XA==@vger.kernel.org, AJvYcCXb6UgBlEMzvCZ3VCRBZwJm9kLfr8fvtVWcS7lPagqcXLWb0SytKF7dgrP+/7+zY1RgnkNCSOy4etam8dEIPMifQw==@vger.kernel.org, AJvYcCXwSDbsq6XqXbKbWoC/d6nEeJizTQq8OBf2TYK+Dh29G6NpyxSQXVUXMjug1kWDE5JwbPpaLtnPMe/qFNVHna+Rctqx@vger.kernel.org
X-Gm-Message-State: AOJu0YwUyk8HjxOOjTH5RoSbkckQLqIq9/b5p9QDj8sFrmWXDSbd7zBb
	RETIIEF1qtNcOhY1hj/SXpae0sbMVoX4Dcq4lG2XuhI4ix+CuuSuuTnDj/0lfYYPZ+8=
X-Gm-Gg: ASbGncsTq2wOGyoDJ3IhiHCsLAo73elOod8a4B9S63dCuNP0ZZfoAjVxwfy2iVMIUZ0
	uqN/qO/BTDNzAXIMPqC4wmgNLVoRcmbO09FVOPzzuphm4yWUMS6M86y5mo5D02nf8UPVOptdtgC
	G//RVSHD53Wq8heqh8ewsk+4hs9X+Zj/0Kt01bUAGt+uirjehtnTAdszj8LB7bUtVXyPrB7UCa8
	2N2IJaBZS+hIvgsd4IjNBFgfv6sDpXf317pgLAsH42sGLFNfXa8+eq7jdpphoyCRWSP1h7ZRVcu
	hmQM6yR9JKzsB3Md+5jkCF7wBPiW/ohQq2D8fR4bmbbCxJH8wLD/n7kg/0a/6vf2G076dhgOARd
	nB9+t1Z4tQ1BBKqtpX7Fx/5MEWCdawtuDcuW64D1xVN7iYYlw8AKAEAolgDnh
X-Google-Smtp-Source: AGHT+IE1J+AW0AMEEiqaet6OiGOZk/hzIXBMdylebzV2SmaVtuyinJakXg/+9VDOjnZLVzI4feXpcQ==
X-Received: by 2002:a05:6e02:1a4c:b0:3ed:eab:439a with SMTP id e9e14a558f8ab-3f400475d88mr158077645ab.12.1756735105932;
        Mon, 01 Sep 2025 06:58:25 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3e07ea04fsm29940595ab.25.2025.09.01.06.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:58:25 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8873044d611so46683239f.1;
        Mon, 01 Sep 2025 06:58:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUS5YqmU67qM4/ABmrAkAJCKdOCvdDtgVK2AFgFiwihzx21YfOZ0W+rZQbXYLPi5E4xKvQ43jTFSeCck+15@vger.kernel.org,
 AJvYcCUg/+3jdpYxm4bpCGgWJ7aVbv69npnj7c5DUZmlsppOoQ6FxzTrUDiJUuxlabquLMCQt1RwDYQJGg==@vger.kernel.org,
 AJvYcCUn2CbUvtkyFG88YuUQYnva+624tedkL0Qd+KxmDG0r7vboKSUecYLeu/3DsaPnAO0lBF6xwySMiBjg/51E@vger.kernel.org,
 AJvYcCUrgt2NVbgowDyxI9LPiIsxJiN6AhN1NymMkUftPY53HaSzECRDbq7NtifZBAmyszYsp6MlQX4iTQ4=@vger.kernel.org,
 AJvYcCUuEvr87UeSno31ysMo6JkpPqSyt5paj4yx1hSiLNQjaSUTyArEjU3eMYRRk1mp29ss9czxhq8zEgxEjw==@vger.kernel.org,
 AJvYcCV+ts6sMYcJOnntCRU3vJsQDvt+iVy58SmJHi5hwLabDYIf0hW6m7dqKLBfQPoM+TyP/jt9oog4DYimOg==@vger.kernel.org,
 AJvYcCV9ffK3RX8jSxXMalgnqigWjFcWRh22J+Emh4yqH9RC89FkBSXz+/fzTYJ8YLFErNdoUz9c+xtU@vger.kernel.org,
 AJvYcCVAao1Qttj7NHcENAyE8JRuBJufneZFHwKpczRuX8NvJOlNj9R3U8ER+E9TwOQR0TCjqBioOEWUFwJGGTcsFWYWgQ==@vger.kernel.org,
 AJvYcCVnucVCiFAMk46UDvr6gHeKu2x9RyjujKsjeFO68G9dpzS+eWoclRD3LLN2DVz/Il91fpVcpuGV@vger.kernel.org,
 AJvYcCVtFxTLZAMeU+l5eMn3Ad+L6orDWE2PO71aHWYWqDEt+nFG/Jap+NcQXfIHcYdjRN50AJeFjgL/LQh7fw==@vger.kernel.org,
 AJvYcCVtqsSdCSpF9AF3XYjtVg0ktspu38/42kOz7riEI0Foc1aLh7hHZl9m2yJxIuGyc9bGcB+mFVW9YqO/z10=@vger.kernel.org,
 AJvYcCVvoLYodC8U/JcsCmFFu2AdJvLnt1hsvHCYICYysx4qd7UnUMW2W22MRI+Tuq3cWlg6CCc82b7iReVcRmgFVg==@vger.kernel.org,
 AJvYcCVwxUaV4TERRuoLaXpiRwUkQNN5P3+Op8Ve4/TxnnQ6+1VEd1atmnWGJpx9qq9ZBFD7/MRECqW66XJxZQ==@vger.kernel.org,
 AJvYcCW2hwihokiau9oJoZLUwL6S0pFYtLt7TpGkZhSestGKgUpav9QW+cug26Ax7pexr5/GEUfq+vWJrSvGuFmidK8=@vger.kernel.org,
 AJvYcCWAMFF+j80ZiO88t2JPIF0QxDmQWvWMJ7730a4AcruwNz5tww3fttvVoBsvuXzOKolzTxO6kMLAtOqsqqve4g==@vger.kernel.org,
 AJvYcCWFMqLfYqkrqukIzoFX9uHfJ8NxuKFCKENdkvRFL3kbFejcrbL6mwOru3uJo++oDsrO5UboYATBQi8YPcw=@vger.kernel.org,
 AJvYcCXBW+kMjmply+YARH3geGX0gj2rM8QakCmir//t5q9DtT+RObNyGsWo1kUlZ09Z+mYLX7BdAFPAYPS1UQLtS763539D@vger.kernel.org,
 AJvYcCXBWYTcLnG07iyMSiB2MoZFjcHdmtPgK+exmYc1V3jJNtAU45g1rgGiXuR2QiI+XQ2i4OaqiBab+xd1OyaWbe9o239AVzvZ@vger.kernel.org
X-Received: by 2002:a05:6102:3053:b0:52a:c340:11db with SMTP id
 ada2fe7eead31-52b1bb24afcmr2206016137.27.1756734711158; Mon, 01 Sep 2025
 06:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
In-Reply-To: <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 15:51:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyCbOgs6XyW=8PG2pVw1-zhWP_VtsXsGz1HeFrZ6kjdA@mail.gmail.com>
X-Gm-Features: Ac12FXxyJUafI_d6iF6chcUi31LuXt_e8cojxsF4wFcxCNHCg2s17r6RQqbjdms
Message-ID: <CAMuHMdWyCbOgs6XyW=8PG2pVw1-zhWP_VtsXsGz1HeFrZ6kjdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arch: copy_thread: pass clone_flags as u64
To: schuster.simon@siemens-energy.com
Cc: Dinh Nguyen <dinguyen@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Johansen <john.johansen@canonical.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Sept 2025 at 15:10, Simon Schuster via B4 Relay
<devnull+schuster.simon.siemens-energy.com@kernel.org> wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
>
> With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> clone3") the effective bit width of clone_flags on all architectures was
> increased from 32-bit to 64-bit, with a new type of u64 for the flags.
> However, for most consumers of clone_flags the interface was not
> changed from the previous type of unsigned long.
>
> While this works fine as long as none of the new 64-bit flag bits
> (CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is still
> undesirable in terms of the principle of least surprise.
>
> Thus, this commit fixes all relevant interfaces of the copy_thread
> function that is called from copy_process to consistently pass
> clone_flags as u64, so that no truncation to 32-bit integers occurs on
> 32-bit architectures.
>
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>

Fixes: c5febea0956fd387 ("fork: Pass struct kernel_clone_args into copy_thread")

>  arch/m68k/kernel/process.c       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

