Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856647654C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjG0NST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjG0NSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:18:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E87271F;
        Thu, 27 Jul 2023 06:18:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9a2033978so14268101fa.0;
        Thu, 27 Jul 2023 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690463894; x=1691068694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fyriAuR62oiOhWCN6FxF1ilSFj6jT3X3Z5HG3vr+EI=;
        b=KN26IBq1GW3sLBHlKq6ESKSVTnXPVg1dTJQ8f2z3dqnXJDI7++FyJBa/0eMQzsKiSs
         mtb6aoFp3JbW04zMM6RSnv8iaqeS+e9LdyYCc5+za8qQQmpj6ZbnALJzvVhcSG0m3Keg
         2aDy8GOc2wnK+ZrbbJdLyr2IXn0Vve0q2iacG5LHcyg3qJazWlGLxp0SZfQ04HwqTD9H
         zdbClAzMB9DEVc/ew6odf68/Nb4DnDysNSKg6biVjeoOoC/1VugMUesjzBS8jHdO8vGM
         Xl+AHgU+OaVP+XDjf+ka9pxznPdqoqYW4LWqetF3JSBwy0Z8aB0EUFBrYAhKxibBK1o0
         1CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463894; x=1691068694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fyriAuR62oiOhWCN6FxF1ilSFj6jT3X3Z5HG3vr+EI=;
        b=eKauDRsiUjGbjbrH/hRgf/2D1GhqmI+WUMx/fD+srnPy2oGgaSWxTNyDR3ih35b65v
         qIRhYfmbq8M9zV7iYh505yjCzpOq0CXAXY72LhTw5AFZb9zFlzm82UmbvB2WTbdc/ZMi
         RAESL9fkolOuXQCIKqS2MNZcjvhE8hhrSIa9AO66rUP8ku/IhY2qhIgCR67O1rqbuA+v
         Vov8iO96I71DAwqrieWwhxDJryIsIwCJkmlxl4IAF06LK393r0q9cKc2ONF1cXke8IUe
         a94JmSYKf5dcd9lbaraGRP8mjoN26a43Bq4c8SEOHwwmtsYoZ8lPcHeHfqx8+LSUtFpx
         vIPA==
X-Gm-Message-State: ABy/qLZjedNu3prMrMHwTaKAdGw2liKEiT7A91jHssKnGzoetDsYZdpz
        o2Xd+yWH7ENt27cYDoMuAnIVa6UUwp0A2c1UwlI=
X-Google-Smtp-Source: APBJJlEGjd/T0bgXXtGhJ1s8iRyIgQPP1P+6/F4Tu5sqBaa2EpBLrKbLA7+i632bjV4hDOXvpfWcBuHLrLfwpr0IziE=
X-Received: by 2002:a2e:8490:0:b0:2b5:1b80:264b with SMTP id
 b16-20020a2e8490000000b002b51b80264bmr1809793ljh.12.1690463893637; Thu, 27
 Jul 2023 06:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-5-amiculas@cisco.com>
 <CALNs47svt4481_3Te9FzskAJ29ur6h115NdLfej3Ejfcd5tO7w@mail.gmail.com>
In-Reply-To: <CALNs47svt4481_3Te9FzskAJ29ur6h115NdLfej3Ejfcd5tO7w@mail.gmail.com>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Thu, 27 Jul 2023 16:18:02 +0300
Message-ID: <CAPDJoNutF=eWFTx5GsP579ayQBBjXXVjA1JjX8rbZu7m2jwW2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] rust: file: Add a new RegularFile newtype
 useful for reading files
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Ariel Miculas <amiculas@cisco.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 2:52=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Wed, Jul 26, 2023 at 12:54=E2=80=AFPM Ariel Miculas <amiculas@cisco.co=
m> wrote:
> >
> > Implement from_path, from_path_in_root_mnt, read_with_offset,
> > read_to_end and get_file_size methods for a RegularFile newtype.
> >
> > Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> > ---
> >  rust/helpers.c       |   6 ++
> >  rust/kernel/error.rs |   4 +-
> >  rust/kernel/file.rs  | 129 ++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 135 insertions(+), 4 deletions(-)
> >
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index eed8ace52fb5..9e860a554cda 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -213,6 +213,12 @@ void *rust_helper_alloc_inode_sb(struct super_bloc=
k *sb,
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_alloc_inode_sb);
> >
> > +loff_t rust_helper_i_size_read(const struct inode *inode)
> > +{
> > +       return i_size_read(inode);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
> > +
> >  /*
> >   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t=
` type
> >   * as the Rust `usize` type, so we can use it in contexts where Rust
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index 05fcab6abfe6..e061c83f806a 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -273,9 +273,7 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
> >  ///     }
> >  /// }
> >  /// ```
> > -// TODO: Remove `dead_code` marker once an in-kernel client is availab=
le.
> > -#[allow(dead_code)]
> > -pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> > +pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> >      // CAST: Casting a pointer to `*const core::ffi::c_void` is always=
 valid.
> >      let const_ptr: *const core::ffi::c_void =3D ptr.cast();
> >      // SAFETY: The FFI function does not deref the pointer.
> > diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> > index 494939ba74df..a3002c416dbb 100644
> > --- a/rust/kernel/file.rs
> > +++ b/rust/kernel/file.rs
> > @@ -8,11 +8,13 @@
> >  use crate::{
> >      bindings,
> >      cred::Credential,
> > -    error::{code::*, from_result, Error, Result},
> > +    error::{code::*, from_err_ptr, from_result, Error, Result},
> >      fs,
> >      io_buffer::{IoBufferReader, IoBufferWriter},
> >      iov_iter::IovIter,
> >      mm,
> > +    mount::Vfsmount,
> > +    str::CStr,
> >      sync::CondVar,
> >      types::ARef,
> >      types::AlwaysRefCounted,
> > @@ -20,6 +22,7 @@
> >      types::Opaque,
> >      user_ptr::{UserSlicePtr, UserSlicePtrReader, UserSlicePtrWriter},
> >  };
> > +use alloc::vec::Vec;
> >  use core::convert::{TryFrom, TryInto};
> >  use core::{marker, mem, ptr};
> >  use macros::vtable;
> > @@ -201,6 +204,130 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> >      }
> >  }
> >
> > +/// A newtype over file, specific to regular files
> > +pub struct RegularFile(ARef<File>);
> > +impl RegularFile {
> > +    /// Creates a new instance of Self if the file is a regular file
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure file_ptr.f_inode is initialized to a va=
lid pointer (e.g. file_ptr is
> > +    /// a pointer returned by path_openat); It must also ensure that f=
ile_ptr's reference count was
> > +    /// incremented at least once
> > +    fn create_if_regular(file_ptr: ptr::NonNull<bindings::file>) -> Re=
sult<RegularFile> {
>
> This function should be unsafe, correct? You instead take a
> `&bindings::file` instead of `NonNull` but still keep it unsafe, so
> the "valid pointer" invariant is always reached.
>
> Or, could this take `&kernel::file::File` instead to reduce some duplicat=
ion?
>
Yes, this should have been unsafe, I've also changed it to receive a
`*mut bindings::file` instead of NonNull.
> > +        // SAFETY: file_ptr is a NonNull pointer
> > +        let inode =3D unsafe { core::ptr::addr_of!((*file_ptr.as_ptr()=
).f_inode).read() };
> > +        // SAFETY: the caller must ensure f_inode is initialized to a =
valid pointer
> > +        unsafe {
> > +            if bindings::S_IFMT & ((*inode).i_mode) as u32 !=3D bindin=
gs::S_IFREG {
> > +                return Err(EINVAL);
> > +            }
> > +        }
>
> Nit: factor `unsafe { ((*inode).i_mode) }` out so it doesn't look like
> the whole statement is unsafe
>
> > +        // SAFETY: the safety requirements state that file_ptr's refer=
ence count was incremented at
> > +        // least once
> > +        Ok(RegularFile(unsafe { ARef::from_raw(file_ptr.cast()) }))
> > +    }
> > +    /// Constructs a new [`struct file`] wrapper from a path.
> > +    pub fn from_path(filename: &CStr, flags: i32, mode: u16) -> Result=
<Self> {
> > +        let file_ptr =3D unsafe {
> > +            // SAFETY: filename is a reference, so it's a valid pointe=
r
> > +            from_err_ptr(bindings::filp_open(
> > +                filename.as_ptr() as *const i8,
> > +                flags,
> > +                mode,
> > +            ))?
> > +        };
>
> I mentioned in another email that `.cast::<i8>()` can be more
> idiomatic and a bit safer than `as`, it's a stylistic choice but there
> are a few places it could be changed here if desired
Thanks, didn't know about this.
>
> Also, the `// SAFETY` comments need to go outside the unsafe block
>
> > +        let file_ptr =3D ptr::NonNull::new(file_ptr).ok_or(ENOENT)?;
> > +
> > +        // SAFETY: `filp_open` initializes the refcount with 1
> > +        Self::create_if_regular(file_ptr)
> > +    }
>
> Will need unsafe block if `create_if_regular` becomes unsafe
>
> > +
> > +    /// Constructs a new [`struct file`] wrapper from a path and a vfs=
mount.
> > +    pub fn from_path_in_root_mnt(
> > +        mount: &Vfsmount,
> > +        filename: &CStr,
> > +        flags: i32,
> > +        mode: u16,
> > +    ) -> Result<Self> {
> > +        let file_ptr =3D {
> > +            let mnt =3D mount.get();
> > +            // construct a path from vfsmount, see file_open_root_mnt
> > +            let raw_path =3D bindings::path {
> > +                mnt,
> > +                // SAFETY: Vfsmount structure stores a valid vfsmount =
object
> > +                dentry: unsafe { (*mnt).mnt_root },
> > +            };
> > +            unsafe {
> > +                // SAFETY: raw_path and filename are both references
> > +                from_err_ptr(bindings::file_open_root(
> > +                    &raw_path,
> > +                    filename.as_ptr() as *const i8,
> > +                    flags,
> > +                    mode,
> > +                ))?
> > +            }
> > +        };
>
> Is there a reason to use the larger scope block, rather than moving
> `mnt` and `raw_path` out and doing `let file_ptr =3D unsafe { ... }`? If
> so, a comment would be good.
No, that's just how the code has evolved from splitting unsafe blocks,
I've changed this in
https://github.com/ariel-miculas/linux/tree/puzzlefs_rfc
>
> > +        let file_ptr =3D ptr::NonNull::new(file_ptr).ok_or(ENOENT)?;
> > +
> > +        // SAFETY: `file_open_root` initializes the refcount with 1
> > +        Self::create_if_regular(file_ptr)
> > +    }
> > +
> > +    /// Read from the file into the specified buffer
> > +    pub fn read_with_offset(&self, buf: &mut [u8], offset: u64) -> Res=
ult<usize> {
> > +        Ok({
> > +            // kernel_read_file expects a pointer to a "void *" buffer
> > +            let mut ptr_to_buf =3D buf.as_mut_ptr() as *mut core::ffi:=
:c_void;
> > +            // Unless we give a non-null pointer to the file size:
> > +            // 1. we cannot give a non-zero value for the offset
> > +            // 2. we cannot have offset 0 and buffer_size > file_size
> > +            let mut file_size =3D 0;
> > +
> > +            // SAFETY: 'file' is valid because it's taken from Self, '=
buf' and 'file_size` are
> > +            // references to the stack variables 'ptr_to_buf' and 'fil=
e_size'; ptr_to_buf is also
> > +            // a pointer to a valid buffer that was obtained from a re=
ference
> > +            let result =3D unsafe {
> > +                bindings::kernel_read_file(
> > +                    self.0 .0.get(),
>
> Is this spacing intentional? If so, `(self.0).0.get()` may be cleaner
No, it's not intentional, this is rustfmt`s creation.
>
> > +                    offset.try_into()?,
> > +                    &mut ptr_to_buf,
> > +                    buf.len(),
> > +                    &mut file_size,
> > +                    bindings::kernel_read_file_id_READING_UNKNOWN,
> > +                )
> > +            };
> > +
> > +            // kernel_read_file returns the number of bytes read on su=
ccess or negative on error.
> > +            if result < 0 {
> > +                return Err(Error::from_errno(result.try_into()?));
> > +            }
> > +
> > +            result.try_into()?
> > +        })
> > +    }
>
> I think you could remove the block here and just return `Ok(result.try_in=
to()?)`
Good idea.
>
> > +
> > +    /// Allocate and return a vector containing the contents of the en=
tire file
> > +    pub fn read_to_end(&self) -> Result<Vec<u8>> {
> > +        let file_size =3D self.get_file_size()?;
> > +        let mut buffer =3D Vec::try_with_capacity(file_size)?;
> > +        buffer.try_resize(file_size, 0)?;
> > +        self.read_with_offset(&mut buffer, 0)?;
> > +        Ok(buffer)
> > +    }
> > +
> > +    fn get_file_size(&self) -> Result<usize> {
> > +        // SAFETY: 'file' is valid because it's taken from Self
> > +        let file_size =3D unsafe { bindings::i_size_read((*self.0 .0.g=
et()).f_inode) };
> > +
> > +        if file_size < 0 {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        Ok(file_size.try_into()?)
> > +    }
> > +}
> > +
> >  /// A file descriptor reservation.
> >  ///
> >  /// This allows the creation of a file descriptor in two steps: first,=
 we reserve a slot for it,
> > --
> > 2.41.0
> >
> >
>
