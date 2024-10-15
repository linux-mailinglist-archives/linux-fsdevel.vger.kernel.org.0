Return-Path: <linux-fsdevel+bounces-32001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53499EEB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D05E1F25C0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81A1C07F2;
	Tue, 15 Oct 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inCvcumD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C581B21B3;
	Tue, 15 Oct 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001208; cv=none; b=kkbXwH/22cIHnX/EkTCEs6LJd3jnKkjpSEBjWFysHOjdoshq+zUmEII+nBWNccytO0vln8MofWFZqOD/KC2u8EA5tc6SPNpJpoaKUlohKJAKpye3rH23y6MQqasEzcC6vSgoIShag0IwooaXr1g36W+3rtEOHkeZRlS3yqDiqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001208; c=relaxed/simple;
	bh=JgfvB1NaPsyFhHEuVgNSRplHSzgilktgmczNQ+Bcznw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw8OOrxcXSVOsB9vKsdju+Tjln4GMV6y9eeY2+IGi5Vpp8Nvk3dB1tm98Ssar8mDS7B1Ei9V/302X1OAUqxoZZAxbCX5ms72idtjsCQlOk3TSEwAIQlHbjd2v1E9AUMkrFQfgjGZ6zyJoe8Qhvj8+AK2CAwcEgGbhdcqYpWIrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inCvcumD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AFEC4CED2;
	Tue, 15 Oct 2024 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729001208;
	bh=JgfvB1NaPsyFhHEuVgNSRplHSzgilktgmczNQ+Bcznw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inCvcumDFS5Jumb40+ZkZKQNL/eMQm+1MDr7TgW+5Sukm4bZr4jP0Vr/7Bu9mrA9H
	 0WXKDZQjqHPY4duwmPIXcFbXyAqlR/Jp6H8x80kLgXSXfZtVoEZNnHjCiIPC8H5r27
	 Juy4tJqATsoqURWzokVFc5tfAtj/GxhHjzY/5K/w2fvR297fteZA8pWyVio8Inx/v+
	 TvLEy7t2WJjKc7tPR/H/ZI7HSavtjidtj107HyuTpCWEJ5kxXGSVZwp6y/US0+hEVx
	 bgQcEZ29iuoLFuVnNYqq1lQ4w4MJj+Rd4BxbU7QWn3Zvph6prTjy+NZllCzba9BAd5
	 ouDNPz1TTl+qQ==
Date: Tue, 15 Oct 2024 16:06:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: task: adjust safety comments in Task methods
Message-ID: <20241015-ohnehin-lorbeerblatt-f6629b558f4f@brauner>
References: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>

On Tue, Oct 15, 2024 at 02:02:12PM +0000, Alice Ryhl wrote:
> The `Task` struct has several safety comments that aren't so great. For
> example, the reason that it's okay to read the `pid` is that the field
> is immutable, so there is no data race, which is not what the safety
> comment says.
> 
> Thus, improve the safety comments. Also add an `as_ptr` helper. This
> makes it easier to read the various accessors on Task, as `self.0` may
> be confusing syntax for new Rust users.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This is based on top of vfs.rust.file as the file series adds some new
> task methods. Christian, can you take this through that tree?

Absolutely.

> ---
>  rust/kernel/task.rs | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 1a36a9f19368..080599075875 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -145,11 +145,17 @@ fn deref(&self) -> &Self::Target {
>          }
>      }
>  
> +    /// Returns a raw pointer to the task.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::task_struct {
> +        self.0.get()
> +    }
> +
>      /// Returns the group leader of the given task.
>      pub fn group_leader(&self) -> &Task {
> -        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> -        // have a valid `group_leader`.
> -        let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
> +        // SAFETY: The group leader of a task never changes after initialization, so reading this
> +        // field is not a data race.
> +        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
>  
>          // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
>          // and given that a task has a reference to its group leader, we know it must be valid for
> @@ -159,42 +165,41 @@ pub fn group_leader(&self) -> &Task {
>  
>      /// Returns the PID of the given task.
>      pub fn pid(&self) -> Pid {
> -        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> -        // have a valid pid.
> -        unsafe { *ptr::addr_of!((*self.0.get()).pid) }
> +        // SAFETY: The pid of a task never changes after initialization, so reading this field is
> +        // not a data race.
> +        unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
>      }
>  
>      /// Returns the UID of the given task.
>      pub fn uid(&self) -> Kuid {
> -        // SAFETY: By the type invariant, we know that `self.0` is valid.
> -        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
> +        // SAFETY: It's always safe to call `task_uid` on a valid task.
> +        Kuid::from_raw(unsafe { bindings::task_uid(self.as_ptr()) })
>      }
>  
>      /// Returns the effective UID of the given task.
>      pub fn euid(&self) -> Kuid {
> -        // SAFETY: By the type invariant, we know that `self.0` is valid.
> -        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
> +        // SAFETY: It's always safe to call `task_euid` on a valid task.
> +        Kuid::from_raw(unsafe { bindings::task_euid(self.as_ptr()) })
>      }
>  
>      /// Determines whether the given task has pending signals.
>      pub fn signal_pending(&self) -> bool {
> -        // SAFETY: By the type invariant, we know that `self.0` is valid.
> -        unsafe { bindings::signal_pending(self.0.get()) != 0 }
> +        // SAFETY: It's always safe to call `signal_pending` on a valid task.
> +        unsafe { bindings::signal_pending(self.as_ptr()) != 0 }
>      }
>  
>      /// Returns the given task's pid in the current pid namespace.
>      pub fn pid_in_current_ns(&self) -> Pid {
> -        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
> -        // pointer as the namespace is correct for using the current namespace.
> -        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
> +        // SAFETY: It's valid to pass a null pointer as the namespace (defaults to current
> +        // namespace). The task pointer is also valid.
> +        unsafe { bindings::task_tgid_nr_ns(self.as_ptr(), ptr::null_mut()) }
>      }
>  
>      /// Wakes up the task.
>      pub fn wake_up(&self) {
> -        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
> -        // And `wake_up_process` is safe to be called for any valid task, even if the task is
> +        // SAFETY: It's always safe to call `signal_pending` on a valid task, even if the task
>          // running.
> -        unsafe { bindings::wake_up_process(self.0.get()) };
> +        unsafe { bindings::wake_up_process(self.as_ptr()) };
>      }
>  }
>  
> @@ -202,7 +207,7 @@ pub fn wake_up(&self) {
>  unsafe impl crate::types::AlwaysRefCounted for Task {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> -        unsafe { bindings::get_task_struct(self.0.get()) };
> +        unsafe { bindings::get_task_struct(self.as_ptr()) };
>      }
>  
>      unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> 
> ---
> base-commit: 22018a5a54a3d353bf0fee7364b2b8018ed4c5a6
> change-id: 20241015-task-safety-cmnts-a7cfe4b2c470
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

